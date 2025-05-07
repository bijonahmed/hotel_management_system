import React, { useState, useEffect } from "react";
import axios from "/config/axiosConfig";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";

const Sliders = () => {
  const [sliders, setSliders] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchSliders = async () => {
      try {
        const response = await axios.get("/public/getSliders");
  
        // Access the array correctly now
        if (Array.isArray(response.data.data)) {
          console.log("Slider Data:", response.data.data);
          setSliders(response.data.data);
        } else {
          console.warn("Invalid slider data:", response.data);
          setSliders([]);
        }
      } catch (error) {
        console.error("Error fetching sliders:", error);
      }
    };
  
    fetchSliders();
  }, []);
  
  

  return (
    <div className="container-fluid p-0 mb-5">
      <div
        id="header-carousel"
        className="carousel slide"
        data-bs-ride="carousel"
      >
        <div className="carousel-inner">
          {sliders.map((slider, index) => (
            <div
              className={`carousel-item ${index === 0 ? "active" : ""}`}
              key={slider.id || index}
            >
              <img
                className="w-100"
                src={slider.sliderImage || "/img/default.jpg"}
                alt={slider.title_name || `Slide ${index + 1}`}
                style={{ height: "100%" }}
              />
              <div className="carousel-caption d-flex flex-column align-items-center justify-content-center">
                <div
                  className="p-3"
                  style={{ maxWidth: "700px", maxHeight: "250px" }}
                >
                  <h6 className="section-title text-white text-uppercase mb-3 animated slideInDown d-none">
                    {slider.title_name || "Resort"}
                  </h6>
                  <h1 className="display-3 text-white mb-4 animated slideInDown">
                    {slider.title_name || "Moon Nest is a very soothing resort"}
                  </h1>
                  <Link
                    to={"/room"}
                    className="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft"
                  >
                    {"Our Rooms"}
                  </Link>
                  <Link
                    to={"/room"}
                    className="btn btn-light py-md-3 px-md-5 animated slideInRight"
                  >
                    {"Book A Room"}
                  </Link>
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Carousel Controls */}
        <button
          className="carousel-control-prev"
          type="button"
          data-bs-target="#header-carousel"
          data-bs-slide="prev"
        >
          <span className="carousel-control-prev-icon" aria-hidden="true" />
          <span className="visually-hidden">Previous</span>
        </button>
        <button
          className="carousel-control-next"
          type="button"
          data-bs-target="#header-carousel"
          data-bs-slide="next"
        >
          <span className="carousel-control-next-icon" aria-hidden="true" />
          <span className="visually-hidden">Next</span>
        </button>
      </div>
    </div>
  );
};

export default Sliders;
