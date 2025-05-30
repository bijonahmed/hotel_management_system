// src/Navbar.js
import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import AuthUser from "./AuthUser";

import axios from "/config/axiosConfig";
import $ from "jquery";

const BookingFilter = () => {
  const today = new Date().toISOString().split("T")[0]; // "2025-05-20"
  const navigate = useNavigate();
  const [checkIn, setCheckIn] = useState(localStorage.getItem("checkIn") || "");
  const [checkOut, setCheckOut] = useState(
    localStorage.getItem("checkOut") || ""
  );
  const [adult, setAdult] = useState(
    localStorage.getItem("adult") ? parseInt(localStorage.getItem("adult")) : 0
  );
  const [child, setChild] = useState(
    localStorage.getItem("child") ? parseInt(localStorage.getItem("child")) : 0
  );
  const [error, setError] = useState("");
  const [roomData, setRoomData] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    localStorage.setItem("checkIn", checkIn);
    localStorage.setItem("checkOut", checkOut);
    localStorage.setItem("adult", adult);
    localStorage.setItem("child", child);
  }, [checkIn, checkOut, adult, child]);

  const isValidDate = (dateStr) => {
    const today = new Date().toISOString().split("T")[0];
    return dateStr >= today;
  };

  const handleCheckInChange = (e) => {
    const value = e.target.value;
    if (!isValidDate(value)) {
      alert("Please select a valid check-in date.");
      return;
    }
    setCheckIn(value);
  };

  const handleSubmit = async (e) => {
    e.preventDefault(); // Prevent page reload

    if (!checkIn || !checkOut) {
      setError("Please select both Check In and Check Out dates.");
      return;
    }

    const formData = {
      check_in: checkIn,
      check_out: checkOut,
      adult,
      child,
    };

    try {
      setLoading(true);
      const response = await axios.post("/public/filterBooking", formData);
      setRoomData(response.data.rooms);
      const rooms = response.data.rooms;
      localStorage.setItem("checkIn", checkIn);
      localStorage.setItem("checkOut", checkOut);
      localStorage.setItem("adult", adult);
      localStorage.setItem("child", child);

      localStorage.setItem("roomData", JSON.stringify(response.data.rooms));
      navigate("/check-availability-result", { state: { roomData: response.data.rooms } });
    } catch (error) {
      console.error("Booking error:", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <>
      <div className="container-fluid booking wow fadeIn" data-wow-delay="0.1s">
        <div className="container">
          <form onSubmit={handleSubmit}>
            <div className="bg-white shadow rounded p-4">
              <div className="row g-3 align-items-end">
                {/* Error message */}
                {error && (
                  <div className="col-12">
                    <div className="alert alert-danger p-2 mb-2">{error}</div>
                  </div>
                )}

                {/* Check-in */}
                <div className="col-md-3">
                  <label className="form-label fw-semibold text-dark">
                    Check In
                  </label>
                  <input
                    type="date"
                    inputMode="none"
                    className="form-control border-primary shadow-sm"
                    value={checkIn}
                    onChange={(e) => setCheckIn(e.target.value)}
                    min={today}
                    onFocus={(e) => e.target.showPicker?.()}
                  />
                </div>

                {/* Check-out */}
                <div className="col-md-3">
                  <label className="form-label fw-semibold text-dark">
                    Check Out
                  </label>
                  <input
                    type="date"
                    inputMode="none"
                    className="form-control border-primary shadow-sm"
                    value={checkOut}
                    onChange={(e) => setCheckOut(e.target.value)}
                    min={today}
                    onFocus={(e) => e.target.showPicker?.()}
                  />
                </div>

                {/* Adult Counter */}
                <div className="col-md-2">
                  <label className="form-label fw-semibold text-dark">
                    Adult
                  </label>
                  <div className="input-group shadow-sm">
                    <button
                      className="btn btn-outline-primary"
                      type="button"
                      onClick={() => setAdult((prev) => Math.max(0, prev - 1))}
                    >
                      −
                    </button>
                    <input
                      type="text"
                      className="form-control text-center"
                      value={String(adult)}
                      readOnly
                    />
                    <button
                      className="btn btn-outline-primary"
                      type="button"
                      onClick={() =>
                        setAdult((prev) => Math.min(100, prev + 1))
                      }
                    >
                      +
                    </button>
                  </div>
                </div>

                {/* Child Counter */}
                <div className="col-md-2">
                  <label className="form-label fw-semibold text-dark">
                    Child
                  </label>
                  <div className="input-group shadow-sm">
                    <button
                      className="btn btn-outline-primary"
                      type="button"
                      onClick={() => setChild((prev) => Math.max(0, prev - 1))}
                    >
                      −
                    </button>
                    <input
                      type="text"
                      className="form-control text-center"
                      value={String(child)}
                      readOnly
                    />
                    <button
                      className="btn btn-outline-primary"
                      type="button"
                      onClick={() =>
                        setChild((prev) => Math.min(100, prev + 1))
                      }
                    >
                      +
                    </button>
                  </div>
                </div>

                {/* Submit Button */}
                <div className="col-md-2 d-grid">
                  <button
                    className="btn btn-primary py-2 fw-semibold"
                    type="submit"
                  >
                    Check Availability
                  </button>
                </div>
              </div>
            </div>
          </form>
        </div>
       
            {loading ? (
  <div className="text-center py-5">
    <div className="spinner-border text-primary" role="status">
      <span className="visually-hidden">Loading...</span>
    </div>
  </div>
) : (<></>)}
        {/* END */}
      </div>
    </>
  );
};

export default BookingFilter;
