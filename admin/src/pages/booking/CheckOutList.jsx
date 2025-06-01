import React, { useState, useEffect, useRef } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import Pagination from "../../components/Pagination";
import axios from "/config/axiosConfig";
import Swal from "sweetalert2";

const CheckOutList = () => {
  const [bookingrooms, setBookingRooms] = useState([]);
  const [availableRooms, setAvailableRooms] = useState([]);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const bookingTabRef = useRef(null);
  useEffect(() => {
    // Optional: Set default active tab if needed
    if (bookingTabRef.current) {
      new window.bootstrap.Tab(bookingTabRef.current).show();
    }
  }, []);

  const apiUrl = "/booking/checkroomBookingStatus";
  const handleClick = (item) => {
    console.log("booking_id...." + item.booking_id);
    navigate(`/booking/checkout-invoice?booking_id=${item.booking_id}`);
  };

  const printInvoice = (item) => {
    console.log("booking_id...." + item.booking_id);
    navigate(`/booking/print-checkout-invoice?booking_id=${item.booking_id}`);
  };

  const fetchData = async () => {
    setLoading(true);
    try {
      const rawToken = sessionStorage.getItem("token");
      const token = rawToken?.replace(/^"(.*)"$/, "$1");

      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get(apiUrl, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      setBookingRooms(response.data.booking_rooms);
     // setAvailableRooms(response.data.available_rooms);
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  const handleAddNewClick = () => {
    navigate("/roomsetting/add-room");
  };

  // Correctly closed useEffect hook
  useEffect(() => {
    fetchData();
  }, []);

  return (
    <>
      <Helmet>
        <title>CheckOut List</title>
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
                <div className="breadcrumb-title pe-3">CheckOut List</div>
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
                        List
                      </li>
                    </ol>
                  </nav>
                </div>

                <div className="ms-auto d-none">
                  <button
                    type="button"
                    className="btn btn-primary"
                    onClick={handleAddNewClick}
                  >
                    Add New
                  </button>
                </div>
              </div>

              <div className="card radius-10">
                <div className="card-body">
                  <div className="container-fluid">
                    {/* Nav Tabs */}
                    <ul className="nav nav-tabs" id="roomTabs" role="tablist">
                      <li
                        className="nav-item"
                        role="presentation"
                        onClick={fetchData}
                      >
                        <button
                          className="nav-link active"
                          id="booking-tab"
                          data-bs-toggle="tab"
                          data-bs-target="#booking"
                          type="button"
                          role="tab"
                          aria-controls="booking"
                          aria-selected="true"
                          ref={bookingTabRef}
                        >
                          Booking Rooms
                        </button>
                      </li>
                      
                    </ul>

                    {/* Tab Content */}
                    <div className="tab-content mt-3" id="roomTabsContent">
                      {/* Booking Rooms Tab */}
                      <div
                        className="tab-pane fade show active"
                        id="booking"
                        role="tabpanel"
                        aria-labelledby="booking-tab"
                      >
                        {loading ? (
                          <div className="d-flex justify-content-center mt-3">
                            <div className="spinner-border" role="status">
                              <span className="visually-hidden">
                                Loading...
                              </span>
                            </div>
                          </div>
                        ) : (
                          <div className="table-responsive">
                            <div className="card mt-4">
                              <div className="card-header text-center">
                                <h4>Booking Rooms List</h4>
                              </div>
                              <div className="card-body p-0">
                                <table className="table table-striped table-bordered mb-0">
                                  <thead className="thead-dark">
                                    <tr>
                                      <th className="text-center">
                                        Booking ID
                                      </th>
                                      <th className="text-center">Room Name</th>
                                      <th className="text-center">
                                        Booking By
                                      </th>
                                      <th className="text-center">
                                        Check IN/Out
                                      </th>
                                      <th className="text-center">Days</th>
                                      <th className="text-center">Action</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {bookingrooms.length > 0 ? (
                                      bookingrooms.map((item) => (
                                        <tr key={item.id}>
                                          <td className="text-center">
                                            {item.booking_id}
                                          </td>
                                          <td className="text-center">
                                            {item.roomType}
                                          </td>
                                          <td className="text-center">
                                            {item.name}
                                          </td>
                                          <td className="text-center">
                                            {item.checkin} <br />{" "}
                                            {item.checkout}
                                          </td>
                                          <td className="text-center">
                                            {item.total_booking_days}
                                          </td>
                                          <td className="text-center">
                                            {item.invoice_create == 1 && (
                                              <div className="d-grid gap-2">
                                                <button
                                                  type="button"
                                                  className="btn btn-warning btn-sm"
                                                  onClick={() =>
                                                    handleClick(item)
                                                  }
                                                >
                                                  Invoice Edit
                                                </button>

                                                <button
                                                  type="button"
                                                  className="btn btn-success btn-sm"
                                                  onClick={() =>
                                                    printInvoice(item)
                                                  }
                                                >
                                                  Print Invoice
                                                </button>
                                              </div>
                                            )}

                                            {item.invoice_create == 2 && (
                                              <button
                                                type="button"
                                                className="btn btn-warning btn-sm btn-block w-100"
                                                onClick={() =>
                                                  handleClick(item)
                                                }
                                              >
                                                Invoice Create
                                              </button>
                                            )}
                                          </td>
                                        </tr>
                                      ))
                                    ) : (
                                      <tr>
                                        <td
                                          colSpan="6"
                                          className="text-center text-muted"
                                        >
                                          No data found
                                        </td>
                                      </tr>
                                    )}
                                  </tbody>
                                </table>
                              </div>
                            </div>
                          </div>
                        )}
                      </div>

                      {/* Available Rooms Tab */}
                   
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

export default CheckOutList;
