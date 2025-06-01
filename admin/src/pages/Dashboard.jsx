// src/pages/Index.js
import React, { useState, useEffect, useContext } from "react";
import { Helmet } from "react-helmet";
import { Link } from "react-router-dom";
import axios from "/config/axiosConfig";
import GuestNavbar from "../components/Navbar";
import { useNavigate } from "react-router-dom";
import Footer from "../components/Footer";
import Loader from "../components/Loader";
import LeftSideBarComponent from "../components/LeftSideBarComponent";
import { LanguageContext } from "../context/LanguageContext";
import AuthUser from "../components/AuthUser";

const Index = () => {
  const [isLoading, setIsLoading] = useState(true);
  const [loading, setLoading] = useState(true);
  const { content } = useContext(LanguageContext);
  const [bookingData, setBookingData] = useState([]);
  const [todaybookingCount, setTodayBCount] = useState(0);
  const [todaybookingAmt, setbPayment] = useState(0);
  const [coustomerCount, setCustomerCount] = useState(0);
  const [roomCount, setRoomCount] = useState(0);

  const rawToken = sessionStorage.getItem("token");
  const token = rawToken?.replace(/^"(.*)"$/, "$1");
  const [currency_symbol, set_currency_symbol] = useState("");
  const globalSetting = async () => {
    try {
      const response = await axios.get(`/setting/settingrowSystem`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      const userData = response.data.data;
      set_currency_symbol(userData.currency_symbol || "");
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };

  const getBookingList = async () => {
    try {
      setLoading(true);
      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get(`/dashboard/getTodayBookingList`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      setBookingData(response.data);
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
      const response = await axios.get(`/dashboard/countBookingData`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      setTodayBCount(response.data.todayBooking);
      setbPayment(response.data.bookingPayment);
      setCustomerCount(response.data.customerCount);
      setRoomCount(response.data.roomCount);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };
  // Correctly closed useEffect hook
  useEffect(() => {
    countData();
    getBookingList();
    globalSetting();
  }, []);

  return (
    <div>
      <Helmet>
        <title>Dashboard [Hotel Management]</title>
      </Helmet>
      {/* Start */}

      <div>
        <div className="wrapper">
          {/*sidebar wrapper */}
          <LeftSideBarComponent />
          {/*end sidebar wrapper */}
          {/*start header */}
          <header>
            <GuestNavbar />
          </header>
          {/*end header */}
          {/*start page wrapper */}
          <div className="page-wrapper">
            <div className="page-content">
              <div className="row row-cols-1 row-cols-md-2 row-cols-xl-2 row-cols-xxl-4">
                <div className="col">
                  <div className="card radius-10 bg-gradient-cosmic">
                    <div className="card-body">
                      <div className="d-flex align-items-center">
                        <div className="me-auto">
                          <p className="mb-0 text-white">Today Booking</p>
                          <h4 className="my-1 text-white">
                            {todaybookingCount}
                          </h4>
                        </div>
                        <div id="chart1" />
                      </div>
                    </div>
                  </div>
                </div>

                <div className="col">
                  <div className="card radius-10 bg-gradient-kyoto">
                    <div className="card-body">
                      <div className="d-flex align-items-center">
                        <div className="me-auto">
                          <p className="mb-0 text-dark">Today Booking Amount</p>
                          <h4 className="my-1 text-dark">
                            {currency_symbol}&nbsp;{todaybookingAmt}
                          </h4>
                        </div>
                         
                      </div>
                    </div>
                  </div>
                </div>

                <div className="col">
                  <div className="card radius-10 bg-gradient-ibiza">
                    <div className="card-body">
                      <div className="d-flex align-items-center">
                        <div className="me-auto">
                          <p className="mb-0 text-white">Total Customer</p>
                          <h4 className="my-1 text-white">{coustomerCount}</h4>
                        </div>
                       
                      </div>
                    </div>
                  </div>
                </div>
                <div className="col">
                  <div className="card radius-10 bg-gradient-ohhappiness">
                    <div className="card-body">
                      <div className="d-flex align-items-center">
                        <div className="me-auto">
                          <p className="mb-0 text-white">Total Rooms</p>
                          <h4 className="my-1 text-white">{roomCount}</h4>
                        </div>
                        
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              {/*end row*/}

              <div className="card radius-10">
                <div className="card-header">
                  <div className="d-flex align-items-center">
                    <div>
                      <h6 className="mb-0">Today Booking List</h6>
                    </div>
                  </div>
                </div>
                <div className="card-body">
                  {loading ? (
                    <center>
                      <div className="spinner-border" role="status">
                        {" "}
                        <span className="visually-hidden">Loading...</span>
                      </div>
                    </center>
                  ) : (
                    <div className="table-responsive">
                      <table className="table align-middle mb-0 table-hover">
                        <thead className="table-light">
                          <tr>
                            <th>Booking ID</th>
                            <th>Booking By</th>
                            <th>Room Name</th>
                            <th>Room Price / Day</th>
                            <th>Check In/Out</th>
                            <th>Days</th>
                            <th className="text-center">Payment Type</th>
                          </tr>
                        </thead>
                        <tbody>
                          {bookingData.map((data, index) => (
                            <tr key={index}>
                              <td>{data.booking_id}</td>
                              <td>{data.name}</td>
                              <td>{data.room_name}&nbsp;{currency_symbol}</td>
                              <td>{data.roomPrice}&nbsp;{currency_symbol}</td>
                              <td>
                                {data.checkin}
                                <br />
                                {data.checkout}
                              </td>
                              <td>{data.total_booking_days}</td>
                              <td className="text-center">
                                {" "}
                                {data.paymenttype === 1
                                  ? "Online"
                                  : data.paymenttype === 2
                                  ? "Offline"
                                  : "N/A"}
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  )}
                </div>
              </div>
            </div>
          </div>
          {/*end page wrapper */}
          {/*start overlay*/}
          <div className="overlay toggle-icon" />

          <Link to="#" className="back-to-top">
            <i className="bx bxs-up-arrow-alt" />
          </Link>

          <Footer />
        </div>
        {/*end wrapper*/}
      </div>

      {/* END */}
    </div>
  );
};

export default Index;
