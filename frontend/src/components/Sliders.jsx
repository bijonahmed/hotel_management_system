import React, { useState, useEffect, useContext } from "react";
import axios from "/config/axiosConfig";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import $ from "jquery"; // Import jQuery
// import "./css/LeftSideBarComponent.css";
import carousel1 from "/img/carousel-1.jpg";
import carousel2 from "/img/carousel-2.jpg";

const Sliders = () => {

  const navigate = useNavigate();
  useEffect(() => {
    const carousel = new bootstrap.Carousel(document.getElementById("header-carousel"), {
      interval: 3000, // Change slide every 3 seconds
      ride: "carousel",
    });
  }, []);

  return (
    <div className="container-fluid p-0 mb-5">
    <div id="header-carousel" className="carousel slide" data-bs-ride="carousel">
      <div className="carousel-inner">
        <div className="carousel-item active">
          <img className="w-100" src={carousel1 || "/img/carousel-1.jpg"} alt="Luxury Hotel Image" />
          <div className="carousel-caption d-flex flex-column align-items-center justify-content-center">
            <div className="p-3" style={{ maxWidth: 700 }}>
              <h6 className="section-title text-white text-uppercase mb-3 animated slideInDown">Luxury Living</h6>
              <h1 className="display-3 text-white mb-4 animated slideInDown">Discover A Brand Luxurious Hotel</h1>
              <Link to="/" className="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft">Our Rooms</Link>
              <Link to="/" className="btn btn-light py-md-3 px-md-5 animated slideInRight">Book A Room</Link>
            </div>
          </div>
        </div>
        <div className="carousel-item">
          <img className="w-100" src={carousel2 || "/img/carousel-2.jpg"} alt="Best Luxury Hotel Image" />
          <div className="carousel-caption d-flex flex-column align-items-center justify-content-center">
            <div className="p-3" style={{ maxWidth: 700 }}>
              <h6 className="section-title text-white text-uppercase mb-3 animated slideInDown">Luxury Living</h6>
              <h1 className="display-3 text-white mb-4 animated slideInDown">Discover A Brand Luxurious Hotel</h1>
              <Link to="/" className="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft">Our Rooms</Link>
              <Link to="/" className="btn btn-light py-md-3 px-md-5 animated slideInRight">Book A Room</Link>
            </div>
          </div>
        </div>
      </div>
      <button className="carousel-control-prev" type="button" data-bs-target="#header-carousel" data-bs-slide="prev">
        <span className="carousel-control-prev-icon" aria-hidden="true"></span>
        <span className="visually-hidden">Previous</span>
      </button>
      <button className="carousel-control-next" type="button" data-bs-target="#header-carousel" data-bs-slide="next">
        <span className="carousel-control-next-icon" aria-hidden="true"></span>
        <span className="visually-hidden">Next</span>
      </button>
    </div>
  </div>
  );
};

export default Sliders;
