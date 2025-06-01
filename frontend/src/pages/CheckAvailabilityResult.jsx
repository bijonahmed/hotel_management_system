import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig";
import Footer from "../components/Footer";
import Header from "../components/GuestNavbar";
import { useNavigate } from "react-router-dom";
import BookingFilter from "../components/BookingFilter";
import { Helmet } from "react-helmet";
import { useLocation } from "react-router-dom";

const CheckAvailabilityResult = () => {
  const today = new Date().toISOString().split("T")[0]; // "2025-05-20"
  const navigate = useNavigate();

  const location = useLocation();
  const { roomData } = location.state || {
    roomData: JSON.parse(localStorage.getItem("roomData") || "[]"),
  };

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
  //const [roomData, setRoomData] = useState([]);
  const [loading, setLoading] = useState(false);
  console.log("Room Data:", roomData); // Should log the data
  useEffect(() => {
    // Save to localStorage
    localStorage.setItem("checkIn", checkIn);
    localStorage.setItem("checkOut", checkOut);
    localStorage.setItem("adult", adult);
    localStorage.setItem("child", child);

    // Log to console
    console.log("checkIn:", checkIn);
    console.log("checkOut:", checkOut);
    console.log("adult:", adult);
    console.log("child:", child);
  }, [checkIn, checkOut, adult, child]);

  const isValidDate = (dateStr) => {
    const today = new Date().toISOString().split("T")[0];
    return dateStr >= today;
  };

  return (
    <div>
      <Helmet>
        <title>Check Availability</title>
      </Helmet>
      <Header />
      <div
        className="container-fluid page-header mb-5 p-0"
        style={{ backgroundImage: "url(/img/carousel-1.jpg)" }}
      >
        <div className="container-fluid page-header-inner py-5">
          <div className="container text-center pb-5">
            <h1 className="display-3 text-white mb-3 animated slideInDown">
              {roomData.length > 0 && <>Available Room</>}
            </h1>
            <nav aria-label="breadcrumb">
              <ol className="breadcrumb justify-content-center text-uppercase">
                <li className="breadcrumb-item">
                  <Link to="/">Home</Link>
                </li>
              </ol>
            </nav>
          </div>
        </div>
      </div>

      {/* Start Content  */}
      <div className="container-fluid booking">
        <BookingFilter /> <br />
        <div className="container">
          <div className="row">
            {loading ? (
              <div className="text-center py-5">
                <div className="spinner-border text-primary" role="status">
                  <span className="visually-hidden">Loading...</span>
                </div>
              </div>
            ) : (
              <div className="row">
                {roomData.length > 0 ? (
                  roomData.map((room, index) => (
                    <div
                      key={index}
                      className="col-12 col-md-4 mb-4"
                      data-wow-delay={`${0.1 * index}s`}
                    >
                      <div className="room-item shadow rounded">
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

                        <div className="p-4 mt-2" style={{ height: '232px'}}>
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
                            <div
                              dangerouslySetInnerHTML={{
                                __html:
                                  (room.roomDescription?.length > 40
                                    ? room.roomDescription.slice(0, 40) + "..."
                                    : room.roomDescription) || "",
                              }}
                            />
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
                  ))
                ) : (
                  <div className="text-center text-muted py-5">
                    No rooms found.
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
        {/* END */}
      </div>
      {/* END Content  */}
      <Footer />
    </div>
  );
};

export default CheckAvailabilityResult;
