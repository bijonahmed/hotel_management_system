// src/Navbar.js
import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import AuthUser from "../components/AuthUser";

import axios from "/config/axiosConfig";
import $ from "jquery";

const Navbar = () => {
  const navigate = useNavigate();
  const [name, setName] = useState("");

  const fetechGlobalData = async () => {
    try {
      const response = await axios.get(`/public/getGlobalData`);
      // console.log("Navbar API Response:", response.data); // Log the response
      setName(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    }
  };

  useEffect(() => {
    fetechGlobalData();
  }, []);

  return (
    <>
      {/* header  */}
      <div className="container-fluid bg-dark px-0">
        <div className="row gx-0">
          <div className="col-lg-3 bg-dark d-none d-lg-block">
            <Link
              to="/"
              className="navbar-brand w-100 h-100 m-0 p-0 d-flex align-items-center justify-content-center"
            >
              <h1 className="m-0 text-primary text-uppercase">{name.name}</h1>
            </Link>
          </div>
          <div className="col-lg-9">
            <div className="row gx-0 bg-white d-none d-lg-flex">
              <div className="col-lg-7 px-5 text-start">
                <div className="h-100 d-inline-flex align-items-center py-2 me-4">
                  <i className="fa fa-envelope text-primary me-2" />
                  <p className="mb-0">{name.email}</p>
                </div>
                <div className="h-100 d-inline-flex align-items-center py-2">
                  {/* <i className="fa fa-phone-alt text-primary me-2" /> */}
                  <p className="mb-0">
                    <a
                      href={`https://wa.me/${name.whatsApp}`}
                      target="_blank"
                      rel="noopener noreferrer"
                      style={{
                        display: "inline-flex",
                        alignItems: "center",
                        gap: "8px",
                        textDecoration: "none",
                        backgroundColor: "#25D366",
                        color: "white",
                        padding: "6px 16px",
                        borderRadius: "8px",
                        fontWeight: "600",
                        fontSize: "16px",
                        fontFamily: "Segoe UI, sans-serif",
                        boxShadow: "0 2px 8px rgba(0, 0, 0, 0.1)",
                      }}
                    >
                      <i
                        className="fab fa-whatsapp"
                        style={{ fontSize: "18px" }}
                      ></i>
                      {name.whatsApp}
                    </a>
                  </p>
                </div>
              </div>
              <div className="col-lg-5 px-5 text-end">
                <div className="d-inline-flex align-items-center py-2">
                  <a className="me-3" href={name.fblink} target="_blank">
                    <i className="fab fa-facebook-f" />
                  </a>
                  <a target="_blank" href={name.youtubelink}>
                    <i className="fab fa-youtube" />
                  </a>

                  <a className="me-3 d-none" href="#">
                    <i className="fab fa-twitter" />
                  </a>
                  
                  <a className="me-3 d-none" href="#">
                    <i className="fab fa-twitter" />
                  </a>
                  <a className="me-3 d-none" href="#">
                    <i className="fab fa-linkedin-in" />
                  </a>
                  <a className="me-3 d-none" href="#">
                    <i className="fab fa-instagram" />
                  </a>
                </div>
              </div>
            </div>
            <nav className="navbar navbar-expand-lg bg-dark navbar-dark p-3 p-lg-0">
              <Link to="/" className="navbar-brand d-block d-lg-none">
                <h1 className="m-0 text-primary text-uppercase">Moon Nest</h1>
              </Link>
              <button
                type="button"
                className="navbar-toggler"
                data-bs-toggle="collapse"
                data-bs-target="#navbarCollapse"
              >
                <span className="navbar-toggler-icon" />
              </button>
              <div
                className="collapse navbar-collapse justify-content-between"
                id="navbarCollapse"
              >
                <div className="navbar-nav mr-auto py-0">
                  <Link to="/" className="nav-item nav-link active">
                    Home
                  </Link>
               
                  <Link to="/service" className="nav-item nav-link">
                    Services
                  </Link>
                  <Link to="/room" className="nav-item nav-link">
                    Rooms
                  </Link>
                  <Link to="#" className="nav-item nav-link">
                    Login
                  </Link>
                  <Link to="#" className="nav-item nav-link">
                    Register
                  </Link>
                  <Link to="/contact" className="nav-item nav-link">
                    Contact
                  </Link>
                </div>
              </div>
            </nav>
          </div>
        </div>
      </div>
      {/* ------------- Header end ----------------  */}
    </>
  );
};

export default Navbar;
