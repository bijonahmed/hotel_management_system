// src/pages/Index.js
import React, { useState, useEffect, useContext } from "react";
import { Helmet } from "react-helmet";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig";
import GuestNavbar from "../components/Navbar";
import { useNavigate } from "react-router-dom";
import Loader from "../components/Loader";
import Footer from "../components/Footer";
import Header from "../components/GuestNavbar";
import BookingFilter from "../components/BookingFilter";
import AuthUser from "../components/AuthUser";

const Index = () => {
  const [isLoading, setIsLoading] = useState(true);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate(); // already imported from 'react-router-dom'
  const rawToken = sessionStorage.getItem("token");
  const token = rawToken?.replace(/^"(.*)"$/, "$1");
  const [roomData, setRoomData] = useState([]);

  const fetechActiveBookingRooms = async () => {
    setLoading(true);
    try {
      const response = await axios.get(`/booking/activeBookingRooms`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      //console.log("API Response:", response.data); // Log the response
      setRoomData(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    } finally {
      setLoading(false);
    }
  };
  // Correctly closed useEffect hook
  useEffect(() => {
    fetechActiveBookingRooms();
  }, []);

  useEffect(() => {
    if (!token) {
      navigate("/login");
    }
  }, []);

  return (
    <div>
      <Helmet>
        <title>Dashboard</title>
      </Helmet>
      {/* Start */}

      <div>
        <Helmet>
          <title>Dashboard</title>
        </Helmet>
        <div className="bg-white p-0">
          <Header />
          {/* Page Header */}
          <div
            className="container-fluid page-header mb-5 p-0"
            style={{ backgroundImage: "url(/img/carousel-1.jpg)" }}
          >
            <div className="container-fluid page-header-inner py-5">
              <div className="container text-center pb-5">
                <h1 className="display-3 text-white mb-3 animated slideInDown">
                  Dashboard
                </h1>
                <nav aria-label="breadcrumb">
                  <ol className="breadcrumb justify-content-center text-uppercase">
                    <li className="breadcrumb-item">
                      <Link to="/">Home</Link>
                    </li>
                 
                    <li
                      className="breadcrumb-item text-white active"
                      aria-current="page"
                    >
                      Dashboard
                    </li>
                  </ol>
                </nav>
              </div>
            </div>
          </div>

          <BookingFilter />

          {/* start */}
          {/* Room Start */}
          <div className="container-xxl py-1">
            <div className="container">
              <div className="text-center wow fadeInUp" data-wow-delay="0.1s">
                <h6 className="section-title text-center text-primary text-uppercase">
                  Booking History
                </h6>
              </div>
              <div className="row g-4 mt-3">
                {roomData.map((room, index) => (
                  <div
                    key={index}
                    className="col-lg-4 col-md-6 wow fadeInUp"
                    data-wow-delay="0.6s"
                  >
                    <div className="room-item shadow rounded overflow-hidden">
                      <div className="position-relative">
                        <img
                        className="img-responsive"
                        src={room.roomImage || "/img/room-3.jpg"}
                        alt="Room Image"
                        style={{
                          height: "250px",
                          width: "100%",
                          objectFit: "cover",
                        }}
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
                            <small className="fa fa-star text-primary" />
                            <small className="fa fa-star text-primary" />
                            <small className="fa fa-star text-primary" />
                            <small className="fa fa-star text-primary" />
                            <small className="fa fa-star text-primary" />
                          </div>
                        </div>

                        <p
                          style={{
                            backgroundColor: "#f8f9fa",
                            padding: "12px 16px",
                            borderRadius: "8px",
                            fontSize: "16px",
                            color: "#212529",
                            marginBottom: "16px",
                            border: "1px solid #dee2e6",
                            boxShadow: "0 2px 6px rgba(0,0,0,0.05)",
                          }}
                        >
                          <strong>Check in:</strong> {room.checkin} &nbsp;&nbsp;
                          <strong>Check out:</strong> {room.checkout}
                        </p>

                        <div className="d-flex justify-content-between">
                          <Link to={`/booking-history-details/${room.booking_id}`} className="btn btn-sm btn-primary rounded py-2 px-4 w-100">
                            View Detail
                          </Link>
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
          <br />
          <br />
          {/* Room End */}

          {/* end */}
          <Footer />

          <a
            href="#"
            className="btn btn-lg btn-primary btn-lg-square back-to-top"
          >
            <i className="bi bi-arrow-up" />
          </a>
        </div>
      </div>

      {/* END */}
    </div>
  );
};

export default Index;
