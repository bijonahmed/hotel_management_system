import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import Pagination from "../../components/Pagination";
import axios from "/config/axiosConfig";
import "../../components/css/RoleList.css";

const RestaurentReport = () => {
  const [merchantdata, setMerchantData] = useState([]);
  const [data, setData] = useState([]);
  const [bookingData, setBookingData] = useState([]);
  const [invoice_id, setInvId] = useState("");
  const [customer_id, setCustomer] = useState("");
  const [selectedFilter, setSelectedFilter] = useState(1);
  const [fromDate, setFromDate] = useState("");
  const [toDate, setToDate] = useState("");
  const [loading, setLoading] = useState(false);
  const rawToken = sessionStorage.getItem("token");
  const token = rawToken?.replace(/^"(.*)"$/, "$1");
  const apiUrl = "/report/filterByRestReport";

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

  const fetchCustomerData = async () => {
    try {
      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get(`/restaurant/getOnlyCustomerList`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      if (response.data.data) {
        setMerchantData(response.data.data);
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const fetchData = async () => {
    setLoading(true);
    try {
      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get(apiUrl, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
        params: {
          //searchQuery,
          selectedFilter,
          customer_id,
          fromDate,
          toDate,
          invoice_id,
        },
      });

      if (response.data) {
        setData(response.data.restData);
        setBookingData(response.data.bookingData);
        // setTotalPages(response.data.total_pages);
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  const totals = {
    item_total: 0,
    advance_amount: 0,
    due_amount: 0,
    discount_amount: 0,
    after_discount: 0,
    tax_percentage: 0,
    tax_amount: 0,
    grand_total: 0,
  };

  data.forEach((item) => {
    totals.item_total += Number(item.item_total || 0);
    totals.advance_amount += Number(item.advance_amount || 0);
    totals.due_amount += Number(item.due_amount || 0);
    totals.discount_amount += Number(item.discount_amount || 0);
    totals.after_discount += Number(item.after_discount || 0);
    totals.tax_percentage += Number(item.tax_percentage || 0);
    totals.tax_amount += Number(item.tax_amount || 0);
    totals.grand_total += Number(item.grand_total || 0);
  });

  useEffect(() => {
    const today = new Date();
    const priorDate = new Date();
    priorDate.setDate(today.getDate() - 20);

    // Format: YYYY-MM-DD
    const formatDate = (date) => {
      return date.toISOString().split("T")[0];
    };

    setToDate(formatDate(today));
    setFromDate(formatDate(priorDate));
  }, []);

  const totalItemTotal = bookingData.reduce((sum, item) => sum + parseFloat(item.item_total || 0), 0);

  // Correctly closed useEffect hook
  useEffect(() => {
    fetchData();
    fetchCustomerData();
    globalSetting();
  }, [selectedFilter, customer_id, fromDate, toDate, invoice_id]);

  return (
    <>
      <Helmet>
        <title>Restaurent Report</title>
      </Helmet>

      <div>
        <div className="wrapper">
          <LeftSideBarComponent />
          <header>
            <GuestNavbar />
          </header>

          <div className="page-wrapper">
            <div className="page-content">
              <div className="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
                <div className="breadcrumb-title pe-3">Transaction</div>
                <div className="ps-3">
                  <nav aria-label="breadcrumb">
                    <ol className="breadcrumb mb-0 p-0">
                      <li className="breadcrumb-item">
                        <Link to="/dashboard">
                          <i className="bx bx-home-alt" />
                        </Link>
                      </li>
                      <li
                        className="breadcrumb-item active"
                        aria-current="page"
                      >
                        Report
                      </li>
                    </ol>
                  </nav>
                </div>
              </div>

              <div className="card radius-10">
                <div className="card-body">
                  <div className="container-fluid">
                    <div className="search-pagination-container">
                      <div className="row align-items-center mb-3">
                        <div className="col-12 col-md-4 mb-2 mb-md-0">
                          <div className="searchbar">
                            <input
                              type="text"
                              placeholder="Search Invoice No"
                              className="form-control"
                              value={invoice_id}
                              onChange={(e) => setInvId(e.target.value)}
                            />
                          </div>
                        </div>

                        <div className="col-12 col-md-4 mb-2 mb-md-0">
                          <select
                            style={{ height: "46px" }}
                            className="form-select"
                            value={customer_id}
                            onChange={(e) => setCustomer(e.target.value)} // ✅ This line is important
                            id="input46"
                          >
                            <option value="">All Customer</option>
                            {merchantdata.map((user) => (
                              <option key={user.id} value={user.phone}>
                                {user.name} | {user.phone}
                              </option>
                            ))}
                          </select>
                        </div>

                        {/* From Date */}
                        <div className="col-12 col-md-4 mb-2 mb-md-0">
                          <div className="searchbar">
                            <input
                              type="date"
                              className="form-control"
                              value={fromDate}
                              onChange={(e) => setFromDate(e.target.value)}
                            />
                          </div>
                        </div>

                        {/* To Date */}
                        <div className="col-12 col-md-4 mb-2 mb-md-0 mt-3">
                          <div className="searchbar">
                            <input
                              type="date"
                              className="form-control"
                              value={toDate}
                              onChange={(e) => setToDate(e.target.value)}
                            />
                          </div>
                        </div>

                        <div className="col-12 col-md-4 mb-2 mb-md-0 mt-3">
                          <div className="searchbar">
                            <button
                              type="button"
                              className="btn btn-primary"
                              onClick={fetchData}
                            >
                              <i className="fa-solid fa-filter"></i> Filter
                            </button>
                          </div>
                        </div>
                      </div>

                      {loading ? (
                        <div className="d-flex justify-content-center mt-3">
                          <div className="spinner-border" role="status">
                            <span className="visually-hidden">Loading...</span>
                          </div>
                        </div>
                      ) : (
                        <div className="table-responsive">
                          <table className="table align-middle mb-0 table-hover">
                            <thead className="table-light">
                              <tr>
                                <th className="text-left">Invoice No.</th>
                                <th className="text-left">Name</th>
                                <th className="text-left">Phone</th>
                                <th className="text-left">Email</th>
                                <th className="text-end">Item Total</th>
                                <th className="text-end">Adv. Amt</th>
                                <th className="text-end">Due Amt</th>
                                <th className="text-end">Discount Amt</th>
                                <th className="text-end">After Discount Amt</th>
                                <th className="text-end">Tax %</th>
                                <th className="text-end">Tax % Amt</th>
                                <th className="text-end">Grand Total</th>
                                <th className="text-center">Created by</th>
                                <th className="text-center">Action</th>
                              </tr>
                            </thead>
                            <tbody>
                              {data.length > 0 ? (
                                data.map((item) => (
                                  <tr key={item.id}>
                                    <td>{item.invoice_no}</td>
                                    <td className="text-left">{item.name}</td>
                                    <td className="text-left">{item.phone}</td>
                                    <td className="text-left">{item.email}</td>
                                    <td className="text-end">
                                      {item.item_total}
                                    </td>
                                    <td className="text-end bg-warning-subtle">
                                      {item.advance_amount}
                                    </td>
                                    <td className="text-end bg-danger-subtle">
                                      {item.due_amount}
                                    </td>
                                    <td className="text-end bg-info-subtle">
                                      {item.discount_amount}
                                    </td>
                                    <td className="text-end bg-success-subtle">
                                      {item.after_discount}
                                    </td>
                                    <td className="text-end bg-secondary-subtle">
                                      {item.tax_percentage}
                                    </td>
                                    <td className="text-end bg-primary-subtle">
                                      {item.tax_amount}
                                    </td>
                                    <td className="text-end bg-light text-dark fw-bold">
                                      {item.grand_total}
                                    </td>

                                    <td className="text-center">
                                      {item.created_by}
                                    </td>

                                    <td className="text-center">
                                      <Link
                                        to={`/restaurant/print-invoice?invoice_id=${item.id}`}
                                      >
                                        <i className="fa-solid fa-print"></i>{" "}
                                        Print
                                      </Link>
                                    </td>
                                  </tr>
                                ))
                              ) : (
                                <tr>
                                  <td colSpan="9" className="text-center">
                                    No data found
                                  </td>
                                </tr>
                              )}

                              <tr className="fw-bold text-dark bg-light">
                                <td colSpan="4" className="text-end">
                                  Total
                                </td>
                                <td className="text-end">
                                  {totals.item_total.toFixed(2)}
                                </td>
                                <td className="text-end">
                                  {totals.advance_amount.toFixed(2)}
                                </td>
                                <td className="text-end bg-danger text-white">
                                  {totals.due_amount.toFixed(2)}
                                </td>
                                <td className="text-end">
                                  {totals.discount_amount.toFixed(2)}
                                </td>
                                <td className="text-end">
                                  {totals.after_discount.toFixed(2)}
                                </td>
                                <td className="text-end">
                                  {totals.tax_percentage.toFixed(2)}
                                </td>
                                <td className="text-end">
                                  {totals.tax_amount.toFixed(2)}
                                </td>
                                <td className="text-end bg-danger text-white">
                                  {totals.grand_total.toFixed(2)}
                                </td>
                                <td colSpan="2"></td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                      )}

                      <div className="text-end mt-3">
                        <p className="fw-bold">
                          {" "}
                          Balacne:{" "}
                          {(
                            data.reduce(
                              (sum, item) => sum + Number(item.grand_total),
                              0
                            ) - totals.due_amount
                          ).toFixed(2)}
                          {currency_symbol}
                        </p>
                      </div>
                      <center><b><u>Found {bookingData.length} booking(s).</u></b></center>

                      <div className="table-responsive mt-3">
                        <table className="table align-middle mb-0 table-hover">
                          <thead className="table-light">
                            <tr>
                              <th className="text-start">Booking ID.</th>
                              <th className="text-start">Item Total</th>
                              <th className="text-center">Print</th>
                            </tr>
                          </thead>
                          <tbody>
                            {bookingData.length > 0 ? (
                              bookingData.map((item) => (
                                <tr key={item.id}>
                                  <td>{item.booking_id}</td>
                                  <td className="text-start">
                                    {item.item_total}
                                  </td>
                                  <td className="text-center">
                                    <Link
                                      to={`/booking/print-checkout-invoice?booking_id=${item.booking_id}`}
                                    >
                                      <i className="fa-solid fa-print"></i>{" "}
                                      Print
                                    </Link>
                                  </td>
                                </tr>
                              ))
                            ) : (
                              <tr>
                                <td colSpan="3" className="text-center">
                                  No data found
                                </td>
                              </tr>
                            )}

                            {/* Totals Row – soft background */}
                            <tr className="fw-bold bg-light border-top">
                              <td className="text-end">Total</td>
                              <td className="text-start">
                                {totalItemTotal.toFixed(2)}
                              </td>
                              <td></td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="overlay toggle-icon" />
          <Link to="#" className="back-to-top">
            <i className="bx bxs-up-arrow-alt" />
          </Link>
          <Footer />
        </div>
      </div>
    </>
  );
};

export default RestaurentReport;
