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
  const [merchantData, setMerchantData] = useState([]);
  const [depositCount, setDepositCount] = useState(0);
  const [depositAmt, setDepositAmt] = useState(0);
  const [merchantCount, setMerchentCount] = useState(0);
  const [bulkAddressCount, setBulkAddressCount] = useState(0);

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
  //  countData();
   // fetchMerchantData();
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
                          <p className="mb-0 text-white">Today Total Booking</p>
                          <h4 className="my-1 text-white">{depositCount}</h4>
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
                          <p className="mb-0 text-dark">Today Amount</p>
                          <h4 className="my-1 text-dark">${depositAmt}</h4>
                        </div>
                        <div id="chart4" />
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
                          <h4 className="my-1 text-white">{merchantCount}</h4>
                        </div>
                        <div id="chart2" />
                      </div>
                    </div>
                  </div>
                </div>
                <div className="col">
                  <div className="card radius-10 bg-gradient-ohhappiness">
                    <div className="card-body">
                      <div className="d-flex align-items-center">
                        <div className="me-auto">
                          <p className="mb-0 text-white">
                            Total Rooms
                          </p>
                          <h4 className="my-1 text-white">
                            {bulkAddressCount}
                          </h4>
                        </div>
                        <div id="chart3" />
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
                     <div className="spinner-border" role="status"> <span className="visually-hidden">Loading...</span>
                     </div>
                   
                      </center>
                  ) : (
                    <div className="table-responsive">
                      <table className="table align-middle mb-0 table-hover">
                        <thead className="table-light">
                          <tr>
                            <th>Merchant Name</th>
                            <th>Deposit ID</th>
                            <th>Username[ID]</th>
                            <th>Amount</th>
                            <th>Created At</th>
                            <th>Status</th>
                            <th>Crypto Wallet Address</th>
                          </tr>
                        </thead>
                        <tbody>
                          {merchantData.map((data, index) => (
                            <tr key={index}>
                              <td>{data.merchant_name}</td>
                              <td>
                                <small>{data.depositID}</small>
                              </td>
                              <td>
                                <small>
                                  {data.username}[{data.user_id}]
                                </small>
                              </td>
                              <td>
                                <small>${data.deposit_amount}</small>
                              </td>
                              <td>
                                <small>{data.created_at}</small>
                              </td>
                              <td>
                                <small>
                                  <span
                                    className={`badge ${
                                      data.status == 0
                                        ? "bg-gradient-blooker"
                                        : data.status == 1
                                        ? "bg-gradient-quepal"
                                        : data.status == 2
                                        ? "bg-gradient-bloody"
                                        : ""
                                    } text-white shadow-sm w-100`}
                                  >
                                    {data.status == 0
                                      ? "Pending"
                                      : data.status == 1
                                      ? "Active"
                                      : data.status == 2
                                      ? "Rejected"
                                      : ""}
                                  </span>
                                </small>
                              </td>
                              <td>
                                <small>{data.to_crypto_wallet_address}</small>
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
