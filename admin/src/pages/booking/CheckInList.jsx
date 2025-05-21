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

const CheckInList = () => {
  const [status, setStatus] = useState("");
  const [note, setNote] = useState("");
  const [errors, setErrors] = useState({});
  const [bookingrooms, setBookingRooms] = useState([]);
  const [availableRooms, setAvailableRooms] = useState([]);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const bookingTabRef = useRef(null);
  const [searchId, setSearchId] = useState(""); // <-- new

  // inside your component render (or above return)
  const filteredRooms = bookingrooms.filter((item) =>
    item.booking_id.toString().includes(searchId.trim())
  );

  useEffect(() => {
    // Optional: Set default active tab if needed
    if (bookingTabRef.current) {
      new window.bootstrap.Tab(bookingTabRef.current).show();
    }
  }, []);

  const apiUrl = "/booking/checkroomBookingStatus";

  const handleClick = (item) => {
    console.log("booking_id...." + item.booking_id);
    navigate(`/booking/checking-details?booking_id=${item.booking_id}`);
  };

  const handleClickPreview = (item) => {
    console.log("booking_id...." + item.booking_id);
    navigate(`/booking/checking-preview?booking_id=${item.booking_id}`);
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
      setAvailableRooms(response.data.available_rooms);
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  // Correctly closed useEffect hook
  useEffect(() => {
    fetchData();
  }, []);

  return (
    <>
      <Helmet>
        <title>Check In List</title>
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
                <div className="breadcrumb-title pe-3">Check In List</div>
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
              </div>

              <input
                type="text"
                className="form-control"
                placeholder="🔍 Search by Booking ID"
                value={searchId}
                onChange={(e) => setSearchId(e.target.value)}
              />

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
                          Check In
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
                        {/* Optionally show loader */}
                        {loading && (
                          <div className="text-center my-3">
                            <div className="spinner-border" role="status">
                              <span className="visually-hidden">
                                Loading...
                              </span>
                            </div>
                          </div>
                        )}

                        {/* Table */}
                        <table className="table table-striped table-bordered mb-0">
                          <thead className="thead-dark">
                            <tr>
                              <th className="text-center">Booking ID</th>
                              <th className="text-center">Room Name</th>
                              <th className="text-center">Booking By</th>
                              <th className="text-center">Check IN/Out</th>
                              <th className="text-center">Days</th>
                              <th className="text-center">Action</th>
                            </tr>
                          </thead>
                          <tbody>
                            {filteredRooms.length > 0 ? (
                              filteredRooms.map((item) => (
                                <tr key={item.id}>
                                  <td className="text-center">
                                    {item.booking_id}
                                  </td>
                                  <td className="text-center">
                                    {item.roomType}
                                  </td>
                                  <td className="text-center">{item.name}</td>
                                  <td className="text-center">
                                    {item.checkin}
                                    <br />
                                    {item.checkout}
                                  </td>
                                  <td className="text-center">
                                    {item.total_booking_days}
                                  </td>
                                  <td className="text-center">
                                    <div className="btn-group" role="group">
                                      <button
                                        type="button"
                                        className="btn btn-sm btn-outline-success"
                                        onClick={() => handleClick(item)}
                                      >
                                        <i className="fas fa-eye fa-lg"></i>{" "}
                                        Details
                                      </button>
                                      <button
                                        type="button"
                                        className="btn btn-sm btn-outline-primary"
                                        onClick={() => handleClickPreview(item)}
                                      >
                                        <i className="fa-solid fa-magnifying-glass-plus fa-lg"></i>{" "}
                                        Preview
                                      </button>
                                    </div>
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

export default CheckInList;
