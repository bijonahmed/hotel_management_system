// src/Navbar.js
import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import AuthUser from "./AuthUser";

import axios from "/config/axiosConfig";
import $ from "jquery";

const BookingFilter = () => {
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
      //console.log("Booking success:", response.data);
      setRoomData(response.data.rooms);
      // Save values to local storage
      localStorage.setItem("checkIn", checkIn);
      localStorage.setItem("checkOut", checkOut);
      localStorage.setItem("adult", adult);
      localStorage.setItem("child", child);

      // Optional: Show success message or redirect
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
                    className="form-control border-primary shadow-sm"
                    value={checkIn}
                    onChange={(e) => setCheckIn(e.target.value)}
                    min={new Date().toISOString().split("T")[0]}
                  />
                </div>

                {/* Check-out */}
                <div className="col-md-3">
                  <label className="form-label fw-semibold text-dark">
                    Check Out
                  </label>
                  <input
                    type="date"
                    className="form-control border-primary shadow-sm"
                    value={checkOut}
                    onChange={(e) => setCheckOut(e.target.value)}
                    min={new Date().toISOString().split("T")[0]}
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
        {/* Start */}
        {loading ? (
          <div className="d-flex justify-content-center mt-3">
            <div className="spinner-border" role="status">
              <span className="visually-hidden">Loading...</span>
            </div>
          </div>
        ) : (
          <div className="container-xxl py-1">
            <div className="container">
              <div className="text-center wow fadeInUp" data-wow-delay="0.1s">
                {roomData.length > 0 && (
                  <h1 className="mb-5">
                    <br />
                    Available{" "}
                    <span className="text-primary text-uppercase">Rooms</span>
                  </h1>
                )}
              </div>
              <div className="row">
                {roomData.map((room, index) => (
                  <div
                    key={index}
                    className="col-12 mb-4 wow fadeInUp"
                    data-wow-delay={`${0.1 * index}s`}
                  >
                    <div className="room-item shadow rounded overflow-hidden">
                      <div className="position-relative">
                        <img
                          className="img-fluid w-100"
                          style={{ height: "250px", objectFit: "cover" }}
                          src={room.roomImage || "/img/room-3.jpg"}
                          alt="Room Image"
                        />
                        <small className="position-absolute start-0 top-100 translate-middle-y bg-primary text-white rounded py-1 px-3 ms-4">
                          BDT.&nbsp;{room.roomPrice}/Night
                        </small>
                      </div>

                      <div className="p-4 mt-2">
                        <div className="d-flex justify-content-between mb-3">
                          <h5 className="mb-0">
                            {room.name || "Super Deluxe"}
                          </h5>
                          <div className="ps-2">
                            {[...Array(5)].map((_, i) => (
                              <small
                                key={i}
                                className="fa fa-star text-primary"
                              />
                            ))}
                          </div>
                        </div>

                        <div className="d-flex mb-3">
                          <small className="border-end me-3 pe-3">
                            <i className="fa fa-bed text-primary me-2" />
                            {room.bed_name}
                          </small>
                        </div>

                        <p className="text-body mb-3">
                          {room.roomDescription || ""}
                        </p>

                        <div className="d-flex justify-content-between">
                          <Link
                            to={`/booking-details/${room.slug}`}
                            className="btn btn-sm btn-primary rounded py-2 px-4"
                          >
                            View Detail
                          </Link>
                          <Link
                            to={`/booking-details/${room.slug}`}
                            className="btn btn-sm btn-dark rounded py-2 px-4"
                          >
                            Book Now
                          </Link>
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* END */}
      </div>
    </>
  );
};

export default BookingFilter;
