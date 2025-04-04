import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig";
import Footer from "../components/Footer";
import Header from "../components/GuestNavbar";
import Sliders from "../components/Sliders";
import BookingFilter from "../components/BookingFilter";
import Swal from "sweetalert2";

const Index = () => {
  const baseURL = axios.defaults.baseURL;
  const [errors, setErrors] = useState({});
  const [roomData, setRoomData] = useState([]);
  const [loading, setLoading] = useState(false);

  const fetechActiveRooms = async () => {
    setLoading(true);
    try {
      const response = await axios.get(`/public/activeRooms`);
      console.log("API Response:", response.data); // Log the response
      setRoomData(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetechActiveRooms();
  }, []);

  return (
    <div>
      <div className="bg-white p-0">
        <Header />
        <Sliders />

        {/* Booking Start */}
        <BookingFilter/>
        {/* Booking End */}
        {/* About Start */}
        <div className="container-xxl py-5">
          <div className="container">
            <div className="row g-5 align-items-center">
              <div className="col-lg-6">
                <h6 className="section-title text-start text-primary text-uppercase">
                  About Us
                </h6>
                <h1 className="mb-4">
                  Welcome to{" "}
                  <span className="text-primary text-uppercase">MOON NEST</span>
                </h1>
                <p
                  className="mb-4 text-justify"
                  style={{ textAlign: "justify" }}
                >
                  Moon Nest is a very soothing resort. All are wooden bungalow
                  with both sea and hill view sides. There is a bathroom, a
                  couple bed room & a veranda in one bungalow. You will get
                  complementary breakfast for 2 person with one bungalow. Also
                  we have a open restaurant, where you can order fresh drinks,
                  food, sea food and so on. The beautiful beach is 6 to 7 mins
                  walking away from our resort.
                </p>
              </div>
              <div className="col-lg-6">
                <div className="row g-3">
                  <div className="col-6 text-end">
                    <img
                      className="img-fluid rounded w-75 wow zoomIn"
                      data-wow-delay="0.1s"
                      src="img/about-1.jpg"
                      style={{ marginTop: "25%" }}
                    />
                  </div>
                  <div className="col-6 text-start">
                    <img
                      className="img-fluid rounded w-100 wow zoomIn"
                      data-wow-delay="0.3s"
                      src="img/about-2.jpg"
                    />
                  </div>
                  <div className="col-6 text-end">
                    <img
                      className="img-fluid rounded w-50 wow zoomIn"
                      data-wow-delay="0.5s"
                      src="img/about-3.jpg"
                    />
                  </div>
                  <div className="col-6 text-start">
                    <img
                      className="img-fluid rounded w-75 wow zoomIn"
                      data-wow-delay="0.7s"
                      src="img/about-4.jpg"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        {/* About End */}
        {/* Room Start */}
        <div className="container-xxl py-5">
          <div className="container">
            <div className="text-center wow fadeInUp" data-wow-delay="0.1s">
              <h6 className="section-title text-center text-primary text-uppercase">
                Our Rooms
              </h6>
              <h1 className="mb-5">
                Explore Our{" "}
                <span className="text-primary text-uppercase">Rooms</span>
              </h1>
            </div>
            <div className="row g-4">
              {roomData.map((room, index) => (
                <div
                  key={index}
                  className="col-lg-4 col-md-6 wow fadeInUp"
                  data-wow-delay="0.6s"
                >
                  <div className="room-item shadow rounded overflow-hidden">
                    <div className="position-relative">
                      <img
                        className="img-fluid"
                        src={room.roomImage || "/img/room-3.jpg"}
                        alt="Room Image"
                      />
                      <small className="position-absolute start-0 top-100 translate-middle-y bg-primary text-white rounded py-1 px-3 ms-4">
                        BDT.&nbsp;{room.roomPrice}/Night
                      </small>
                    </div>
                    <div className="p-4 mt-2">
                      <div className="d-flex justify-content-between mb-3">
                        <h5 className="mb-0">{room.name || "Super Deluxe"}</h5>
                        <div className="ps-2">
                          <small className="fa fa-star text-primary" />
                          <small className="fa fa-star text-primary" />
                          <small className="fa fa-star text-primary" />
                          <small className="fa fa-star text-primary" />
                          <small className="fa fa-star text-primary" />
                        </div>
                      </div>
                      <div className="d-flex mb-3">
                        <small className="border-end me-3 pe-3">
                          <i className="fa fa-bed text-primary me-2" /> {room.bed_name}
                        </small>
                        {/* <small className="border-end me-3 pe-3">
                          <i className="fa fa-bath text-primary me-2" /> 2 Bath
                        </small>
                        <small>
                          <i className="fa fa-wifi text-primary me-2" /> Wifi
                        </small> */}
                      </div>
                      <p className="text-body mb-3">
                        {room.roomDescription || ""}
                      </p>
                      <div className="d-flex justify-content-between">
                        <Link to={`/booking-details/${room.slug}`} className="btn btn-sm btn-primary rounded py-2 px-4">
                          View Detail
                        </Link>
                        <Link to={`/booking-details/${room.slug}`} className="btn btn-sm btn-dark rounded py-2 px-4">
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
        {/* Room End */}
        {/* Video Start */}

        <div
          className="container-xxl py-5 px-0 wow zoomIn"
          data-wow-delay="0.1s"
        >
          <div className="row g-0">
            <div className="col-md-6 bg-dark d-flex align-items-center">
              <div className="p-5">
                <h6 className="section-title text-start text-white text-uppercase mb-3">
                  Luxury Living
                </h6>
                <h1 className="text-white mb-4">
                  Discover A Brand Luxurious Hotel
                </h1>
                <p className="text-white mb-4">
                  Tempor erat elitr rebum at clita. Diam dolor diam ipsum sit.
                  Aliqu diam amet diam et eos. Clita erat ipsum et lorem et sit,
                  sed stet lorem sit clita duo justo magna dolore erat amet
                </p>
                <a className="btn btn-primary py-md-3 px-md-5 me-3">
                  Our Rooms
                </a>
                <a className="btn btn-light py-md-3 px-md-5">Book A Room</a>
              </div>
            </div>
            <div className="col-md-6">
              <div className="video">
                <button
                  type="button"
                  className="btn-play"
                  data-bs-toggle="modal"
                  data-src="https://www.youtube.com/embed/DWRcNpR6Kdc"
                  data-bs-target="#videoModal"
                >
                  <span />
                </button>
              </div>
            </div>
          </div>
          <br />
          <img className="img-fluid" src="/img/Landing_01.jpg" alt="Images" />
        </div>
        <div
          className="modal fade"
          id="videoModal"
          tabIndex={-1}
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div className="modal-dialog">
            <div className="modal-content rounded-0">
              <div className="modal-header">
                <h5 className="modal-title" id="exampleModalLabel">
                  MOON NEST VIDEO
                </h5>
                <button
                  type="button"
                  className="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                />
              </div>
              <div className="modal-body">
                {/* 16:9 aspect ratio */}
                <div className="ratio ratio-16x9">
                  <iframe
                    width="560"
                    height="315"
                    src="https://www.youtube.com/embed/aoJEbllaj2c?si=kIVLuI-hWyoV19NH"
                    title="YouTube video player"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                    referrerPolicy="strict-origin-when-cross-origin"
                    allowFullScreen
                  ></iframe>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Video Start */}
        {/* Service Start */}
        <div className="container-xxl py-5">
          <div className="container">
            <div className="text-center wow fadeInUp" data-wow-delay="0.1s">
              <h6 className="section-title text-center text-primary text-uppercase">
                Our Services
              </h6>
              <h1 className="mb-5">
                Explore Our{" "}
                <span className="text-primary text-uppercase">Services</span>
              </h1>
            </div>
            <div className="row g-4">
  <div className="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
    <a className="service-item rounded" href="#">
      <div className="service-icon bg-transparent border rounded p-1">
        <div className="w-100 h-100 border rounded d-flex align-items-center justify-content-center">
          <i className="fas fa-mug-hot fa-2x text-primary" />
        </div>
      </div>
      <h5 className="mb-3">Coffee Bar</h5>
    </a>
  </div>

  <div className="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.2s">
    <a className="service-item rounded" href="#">
      <div className="service-icon bg-transparent border rounded p-1">
        <div className="w-100 h-100 border rounded d-flex align-items-center justify-content-center">
          <i className="fas fa-utensils fa-2x text-primary" />
        </div>
      </div>
      <h5 className="mb-3">Restaurant</h5>
    </a>
  </div>

  <div className="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
    <a className="service-item rounded" href="#">
      <div className="service-icon bg-transparent border rounded p-1">
        <div className="w-100 h-100 border rounded d-flex align-items-center justify-content-center">
          <i className="fas fa-concierge-bell fa-2x text-primary" />
        </div>
      </div>
      <h5 className="mb-3">Room Service</h5>
    </a>
  </div>

  <div className="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.4s">
    <a className="service-item rounded" href="#">
      <div className="service-icon bg-transparent border rounded p-1">
        <div className="w-100 h-100 border rounded d-flex align-items-center justify-content-center">
          <i className="fas fa-concierge-bell fa-2x text-primary" />
        </div>
      </div>
      <h5 className="mb-3">24x7 Reception</h5>
    </a>
  </div>

  <div className="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
    <a className="service-item rounded" href="#">
      <div className="service-icon bg-transparent border rounded p-1">
        <div className="w-100 h-100 border rounded d-flex align-items-center justify-content-center">
          <i className="fas fa-car fa-2x text-primary" />
        </div>
      </div>
      <h5 className="mb-3">Car Rental</h5>
    </a>
  </div>

  <div className="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.6s">
    <a className="service-item rounded" href="#">
      <div className="service-icon bg-transparent border rounded p-1">
        <div className="w-100 h-100 border rounded d-flex align-items-center justify-content-center">
          <i className="fas fa-wifi fa-2x text-primary" />
        </div>
      </div>
      <h5 className="mb-3">Secure Wi-Fi</h5>
    </a>
  </div>
</div>

          </div>
        </div>
        {/* Service End */}

        <br />
        {/* Team End */}

        {/* Footer Start */}
        <Footer />
        {/* Footer End */}
        {/* Back to Top */}
        <a
          href="#"
          className="btn btn-lg btn-primary btn-lg-square back-to-top"
        >
          <i className="bi bi-arrow-up" />
        </a>
      </div>
    </div>
  );
};

export default Index;
