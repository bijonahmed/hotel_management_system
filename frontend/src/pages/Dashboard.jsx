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

  const fetchMerchantData = async () => {
    try {
      setLoading(true);
      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get(`/deposit/getDepositList`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      setMerchantData(response.data);
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  const countData = async () => {
    try {
      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get(`/deposit/countMerchantData`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      setDepositCount(response.data.data.countDeposit);
      setDepositAmt(response.data.data.countDepositAmt);
      setMerchentCount(response.data.data.countMerchant);
      setBulkAddressCount(response.data.data.countBulkAddress);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };
  // Correctly closed useEffect hook
  useEffect(() => {
    countData();
    fetchMerchantData();
  }, []);

  useEffect(() => {
    if (!token) {
      navigate("/login");
    }
  }, []);

  return (
    <div>
      <Helmet>
        <title>Dashboard [Payment Getway]</title>
      </Helmet>
      {/* Start */}

      <div>
      

      <Helmet>
        <title>Room</title>
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
                  <li className="breadcrumb-item">
                    <a href="#">Pages</a>
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
                Our Rooms
              </h6>
              <h1 className="mb-5">
                Explore Our{" "}
                <span className="text-primary text-uppercase">Rooms</span>
              </h1>
            </div>
            dddddd
          </div>
        </div>
        <br/><br/>
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
