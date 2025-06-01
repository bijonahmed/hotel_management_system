import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import Pagination from "../../components/Pagination";
import axios from "/config/axiosConfig";
import Swal from "sweetalert2";
import AuthUser from "../../components/AuthUser";

const RoomList = () => {
  const { getToken, token, logout, http, setToken } = AuthUser();
  const [data, setData] = useState([]);
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedFilter, setSelectedFilter] = useState(1);
  const [showavailableRooms, setAvailableRooms] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(10);
  const [totalPages, setTotalPages] = useState(0);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const [sortOrder, setSortOrder] = useState("asc");
  const [errors, setErrors] = useState({});
  const [roomData, setRoomData] = useState([]);
  const [selectedRoomId, setSelectedRoomId] = useState(null);
  const [guestloading, setGuestLoading] = useState(false);
  const [countdown, setCountdown] = useState(0);
  // State to manage form inputs
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    checkin: "",
    checkout: "",
    paymenttype: "",
    adult: 0,
    child: 0,
    room_id: "",
    phone: "",
    message: "",
    account_type: "Guest",
  });

  // Handle form field changes
  const handleChange = (e) => {
    const { id, value } = e.target;

    setFormData({
      ...formData,
      [id]: value,
    });
  };
  //Make Guest Account

  // Handle form submission guest account
  const guestHandleSubmit = async (e) => {
    e.preventDefault();
    setErrors({}); // Reset any previous errors

    try {
      // Convert to FormData (for multipart/form-data)
      const formDataToSend = new FormData();
      Object.entries(formData).forEach(([key, value]) => {
        formDataToSend.append(key, value);
      });

      const response = await axios.post(
        "/booking/adminBookingRequest",
        formDataToSend,
        {
          headers: {
            Authorization: `Bearer ${token}`, // make sure `token` is defined
            "Content-Type": "multipart/form-data",
          },
        }
      );

      // Success toast
      Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
          toast.onmouseenter = Swal.stopTimer;
          toast.onmouseleave = Swal.resumeTimer;
        },
      }).fire({
        icon: "success",
        title: "Successfully booked.",
      });
      // Reset form
      setFormData({
        name: "",
        email: "",
        checkin: "",
        room_id: "",
        checkout: "",
        paymenttype: "",
        adult: 0,
        child: 0,
        slug: "", // reset slug too
        message: "",
        account_type: "",
      });

      navigate("/booking/checkin-list");
      window.location.reload(); // Force reload after navigation
    } catch (error) {
      if (error.response?.status === 422) {
        Swal.fire({
          icon: "error",
          title: "Validation Errors",
          html: Object.values(error.response.data.errors)
            .map((err) => `<div>${err.join("<br>")}</div>`)
            .join(""),
        });
        setErrors(error.response.data.errors);
      } else if (error.response?.status === 409) {
        Swal.fire({
          icon: "warning",
          title: "Booking Conflict",
          text: error.response.data.message,
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "Unexpected Error",
          text: error.message,
        });
      }
    }
  };

  const apiUrl = "/roomsetting/roomList";
  const handleSort = () => {
    const sortedData = [...data].sort((a, b) => {
      if (a.name.toLowerCase() < b.name.toLowerCase()) {
        return sortOrder === "asc" ? -1 : 1;
      }
      if (a.name.toLowerCase() > b.name.toLowerCase()) {
        return sortOrder === "asc" ? 1 : -1;
      }
      return 0;
    });

    setData(sortedData);
    setSortOrder(sortOrder === "asc" ? "desc" : "asc");
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
        params: {
          searchQuery,
          selectedFilter,
          page: currentPage,
          pageSize,
        },
      });

      if (response.data.data) {
        setData(response.data.data);
        setTotalPages(response.data.total_pages);
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  const availableRooms = async () => {
    setLoading(true);
    try {
      const rawToken = sessionStorage.getItem("token");
      const token = rawToken?.replace(/^"(.*)"$/, "$1");

      if (!token) {
        throw new Error("Token not found in sessionStorage");
      }
      const response = await axios.get("/booking/checkroomBookingStatus", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      // console.log("===" + response.data.available_rooms);
      //setBookingRooms(response.data.booking_rooms);
      setAvailableRooms(response.data.available_rooms);
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  const handlePageSizeChange = (e) => {
    setPageSize(Number(e.target.value));
  };

  const handleAddNewClick = () => {
    navigate("/roomsetting/add-room");
  };

  const handleEdit = (id) => {
    navigate(`/roomsetting/room-edit/${id}`);
  };
  const handleAddFacilities = (id) => {
    navigate(`/roomsetting/room-facilities-edit/${id}`);
  };

  const handlePreviewRoom = (id) => {
    navigate(`/roomsetting/room-preview/${id}`);
  };
  const fetechActiveRooms = async () => {
    setLoading(true);
    try {
      const response = await axios.get(`/public/allActiveRooms`);
      //console.log("API Response:", response.data); // Log the response
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

  const handlenewBooking = (id) => {
    setSelectedRoomId(id);

    setFormData((prev) => ({
      ...prev,
      room_id: String(id), // or use Number(id) if room_id is numeric
    }));
    const modal = new window.bootstrap.Modal(
      document.getElementById("bookingModal")
    );
    modal.show();
  };

  const modalBookingCose = () => {
   const modalElement = document.getElementById("bookingModal");
  // ✅ Always get the existing instance
  const modal = window.bootstrap.Modal.getInstance(modalElement);
  if (modal) {
    modal.hide();
  } else {
    console.warn("Modal instance not found.");
  }
  };

  // Correctly closed useEffect hook
  useEffect(() => {
    fetchData();
    availableRooms();
  }, [searchQuery, selectedFilter, currentPage, pageSize]);

  return (
    <>
      <Helmet>
        <title>Room List</title>
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
                <div className="breadcrumb-title pe-3">Room List</div>
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

                <div className="ms-auto">
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
                    <div>
                      <ul className="nav nav-tabs" id="myTab" role="tablist">
                        <li className="nav-item" role="presentation">
                          <button
                            className="nav-link active"
                            id="home-tab"
                            data-bs-toggle="tab"
                            data-bs-target="#home"
                            type="button"
                            role="tab"
                            aria-controls="home"
                            aria-selected="true"
                          >
                            All Rooms
                          </button>
                        </li>
                        <li className="nav-item" role="presentation">
                          <button
                            onClick={availableRooms}
                            className="nav-link"
                            id="profile-tab"
                            data-bs-toggle="tab"
                            data-bs-target="#profile"
                            type="button"
                            role="tab"
                            aria-controls="profile"
                            aria-selected="false"
                          >
                            Available Rooms
                          </button>
                        </li>
                      </ul>
                      <div className="tab-content" id="myTabContent">
                        <br />
                        <div
                          className="tab-pane fade show active"
                          id="home"
                          role="tabpanel"
                          aria-labelledby="home-tab"
                        >
                          {/* Start  */}
                          <div className="search-pagination-container">
                            <div className="row align-items-center mb-3">
                              <div className="col-12 col-md-5 mb-2 mb-md-0">
                                <div className="searchbar">
                                  <input
                                    type="text"
                                    placeholder="Search name..."
                                    className="form-control"
                                    value={searchQuery}
                                    onChange={(e) =>
                                      setSearchQuery(e.target.value)
                                    }
                                  />
                                </div>
                              </div>

                              <div className="col-12 col-md-1 mb-2 mb-md-0">
                                <div className="searchbar">
                                  <select
                                    className="form-select"
                                    value={pageSize}
                                    onChange={handlePageSizeChange}
                                  >
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                    <option value="200">200</option>
                                    <option value="300">300</option>
                                    <option value="400">400</option>
                                    <option value="500">500</option>
                                    <option value="600">600</option>
                                    <option value="700">700</option>
                                  </select>
                                </div>
                              </div>

                              <div className="col-12 col-md-2 d-flex justify-content-between align-items-center gap-2">
                                <select
                                  className="form-select"
                                  value={selectedFilter}
                                  onChange={(e) =>
                                    setSelectedFilter(e.target.value)
                                  }
                                >
                                  <option value="">All Status</option>
                                  <option value="1">Active</option>
                                  <option value="0">Inactive</option>
                                </select>
                                <button
                                  type="button"
                                  className="btn btn-primary"
                                  onClick={fetchData}
                                >
                                  Apply
                                </button>
                              </div>
                            </div>

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
                                <table className="table table-striped table-bordered">
                                  <thead>
                                    <tr>
                                      <td className="text-center">ID</td>
                                      <th
                                        className="text-center"
                                        onClick={handleSort}
                                        style={{ cursor: "pointer" }}
                                      >
                                        Room Type
                                        {sortOrder === "asc" ? (
                                          <span
                                            style={{
                                              marginLeft: "5px",
                                              fontSize: "14px",
                                            }}
                                          >
                                            ↑
                                          </span>
                                        ) : (
                                          <span
                                            style={{
                                              marginLeft: "5px",
                                              fontSize: "14px",
                                            }}
                                          >
                                            ↓
                                          </span>
                                        )}
                                      </th>
                                      {/* <td>Room Type</td> */}
                                      <td className="text-center">
                                        Room Price
                                      </td>
                                      <td className="text-center">Capacity</td>
                                      <th className="text-center">Status</th>
                                      <th className="text-center">Action</th>
                                      <th className="text-center">
                                        Booking Dates
                                      </th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {data.length > 0 ? (
                                      data.map((item) => (
                                        <tr key={item.id}>
                                          <td className="text-center">
                                            {item.id}
                                          </td>
                                          <td>{item.roomType}</td>
                                          {/* <td>{item.roomType}</td> */}
                                          <td className="text-center">
                                            {item.roomPrice}
                                          </td>
                                          <td className="text-center">
                                            {item.capacity}
                                          </td>
                                          <td className="text-center">
                                            {" "}
                                            {item.status}
                                          </td>
                                          <td className="text-center">
                                            <a
                                              href="#"
                                              onClick={() =>
                                                handleEdit(item.id)
                                              }
                                              className="mx-1"
                                            >
                                              <i className="lni lni-pencil-alt"></i>
                                              Edit&nbsp;||
                                            </a>
                                            <a
                                              href="#"
                                              onClick={() =>
                                                handleAddFacilities(item.id)
                                              }
                                              className="mx-1"
                                            >
                                              <i className="lni lni-apartment"></i>{" "}
                                              Add Facilities&nbsp;||
                                            </a>
                                            <a
                                              href="#"
                                              onClick={() =>
                                                handlePreviewRoom(item.id)
                                              }
                                              className="mx-1"
                                            >
                                              <i className="fas fa-eye"></i>
                                              &nbsp;Preview&nbsp;||
                                            </a>
                                            <a
                                              href="#"
                                              onClick={() =>
                                                handlenewBooking(item.id)
                                              }
                                              className="mx-1"
                                            >
                                              <i className="fas fa-plus"></i>
                                              &nbsp;New Booking
                                            </a>
                                          </td>

                                          <td className="text-center">
                                            {item.booking_dates
                                              ?.split("|")
                                              .map((entry, index) => (
                                                <div key={index}>
                                                  {entry.trim()}
                                                </div>
                                              ))}
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
                                  </tbody>
                                </table>
                              </div>
                            )}

                            <div className="d-flex justify-content-center mt-3 gap-1">
                              <Pagination
                                totalPages={totalPages}
                                apiUrl={apiUrl}
                                onPageChange={handlePageChange}
                              />
                            </div>
                          </div>
                          {/* END */}
                        </div>
                        <div
                          className="tab-pane fade"
                          id="profile"
                          role="tabpanel"
                          aria-labelledby="profile-tab"
                        >
                          {/* Start */}
                          <table className="table table-striped table-bordered mb-0">
                            <thead className="thead-dark">
                              <tr>
                                <th className="text-left">Room Name</th>
                                <th className="text-center">Status</th>
                              </tr>
                            </thead>
                            <tbody>
                              {showavailableRooms.length > 0 ? (
                                showavailableRooms.map((item) => (
                                  <tr key={item.id}>
                                    <td className="text-left">
                                      {item.roomType}
                                    </td>

                                    <td className="text-center">
                                      <span
                                        style={{
                                          color: "green",
                                          fontWeight: "bold",
                                        }}
                                      >
                                        Available
                                      </span>
                                    </td>
                                  </tr>
                                ))
                              ) : (
                                <tr>
                                  <td
                                    colSpan="5"
                                    className="text-center text-muted"
                                  >
                                    No data found
                                  </td>
                                </tr>
                              )}
                            </tbody>
                          </table>

                          {/* END */}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Add Modal */}

          <div
            className="modal fade"
            id="bookingModal"
            tabIndex={-1}
            role="dialog"
            aria-labelledby="exampleModalCenterTitle"
            aria-hidden="true"
          >
            <div className="modal-dialog modal-dialog-centered" role="document">
              <div className="modal-content">
                <div className="modal-header">
                  <h5 className="modal-title" id="exampleModalLongTitle">
                    New Booking
                  </h5>
                  <button
                    type="button"
                    className="close"
                      onClick={modalBookingCose}
                   data-bs-dismiss="modal" 
                    aria-label="Close"
                  >
                    <span aria-hidden="true">×</span>
                  </button>
                </div>
                <div
                  className="modal-body modal-lg"
                  style={{ maxWidth: "800px", margin: "0 auto" }}
                >
                  {/* Start */}
                  <div className="">
                    {/* Start */}
                    <div className="card-body">
                      {/* Guest Account Form */}
                      <form onSubmit={guestHandleSubmit}>
                        <div className="row g-3">
                          <div className="col-md-6">
                            <div className="form-floating">
                              <input
                                type="text"
                                className="form-control"
                                id="name"
                                placeholder="Your Name"
                                value={formData.name}
                                onChange={handleChange}
                              />
                              {errors.name && (
                                <div style={{ color: "red" }}>
                                  {errors.name[0]}
                                </div>
                              )}
                              <label htmlFor="name">Your Name</label>
                            </div>
                          </div>
                          <div className="col-md-6">
                            <div className="form-floating">
                              <input
                                type="email"
                                className="form-control"
                                id="email"
                                placeholder="Your Email"
                                value={formData.email}
                                onChange={handleChange}
                              />
                              {errors.email && (
                                <div style={{ color: "red" }}>
                                  {errors.email[0]}
                                </div>
                              )}
                              <label htmlFor="email">Your Email</label>
                            </div>
                          </div>

                          <div className="col-md-12">
                            <div className="form-floating">
                              <input
                                type="phone"
                                className="form-control"
                                id="phone"
                                placeholder="Your Phone"
                                value={formData.phone}
                                onChange={handleChange}
                              />
                              {errors.phone && (
                                <div style={{ color: "red" }}>
                                  {errors.phone[0]}
                                </div>
                              )}
                              <label htmlFor="phone">Your Phone</label>
                            </div>
                          </div>
                          <div className="col-md-6">
                            <div className="form-floating">
                              <input
                                type="date"
                                className="form-control"
                                id="checkin"
                                value={formData.checkin}
                                min={new Date().toISOString().split("T")[0]} // this sets today's date as minimum
                                onChange={handleChange}
                              />
                              {errors.checkin && (
                                <div style={{ color: "red" }}>
                                  {errors.checkin[0]}
                                </div>
                              )}
                              <label htmlFor="checkin">Check In</label>
                            </div>
                          </div>
                          <div className="col-md-6">
                            <div className="form-floating">
                              <input
                                type="date"
                                className="form-control"
                                id="checkout"
                                value={formData.checkout}
                                min={new Date().toISOString().split("T")[0]} // this sets today's date as minimum
                                onChange={handleChange}
                              />
                              {errors.checkout && (
                                <div style={{ color: "red" }}>
                                  {errors.checkout[0]}
                                </div>
                              )}
                              <label htmlFor="checkout">Check Out</label>
                            </div>
                          </div>
                          <div className="col-md-6">
                            <div className="form-floating">
                              <select
                                className="form-select"
                                id="adult"
                                value={formData.adult}
                                onChange={handleChange}
                              >
                                <option value={0}>No Adult</option>
                                <option value={1}>1 Adult</option>
                                <option value={2}>2 Adults</option>
                                <option value={3}>3 Adults</option>
                                <option value={4}>4 Adults</option>
                                <option value={5}>5 Adults</option>
                                <option value={6}>6 Adults</option>
                                <option value={7}>7 Adults</option>
                                <option value={8}>8 Adults</option>
                                <option value={9}>9 Adults</option>
                                <option value={10}>10 Adults</option>
                              </select>
                              <label htmlFor="adult">Adults</label>
                            </div>
                          </div>
                          <div className="col-md-6">
                            <div className="form-floating">
                              <select
                                className="form-select"
                                id="child"
                                value={formData.child}
                                onChange={handleChange}
                              >
                                <option value={0}>No Child</option>
                                <option value={1}>1 Child</option>
                                <option value={2}>2 Children</option>
                                <option value={3}>3 Children</option>
                                <option value={4}>4 Children</option>
                                <option value={5}>5 Children</option>
                                <option value={6}>6 Children</option>
                                <option value={7}>7 Children</option>
                                <option value={8}>8 Children</option>
                                <option value={9}>9 Children</option>
                                <option value={10}>10 Children</option>
                              </select>
                              <label htmlFor="child">Children</label>
                            </div>
                          </div>

                          <div className="col-md-12">
                            <div className="form-floating">
                              <select
                                className="form-select"
                                id="room_id"
                                value={String(formData.room_id)} // Ensure it's a string
                                onChange={handleChange}
                              >
                                <option value="0">Please select</option>
                                {roomData.map((item, index) => (
                                  <option key={index} value={item.id}>
                                    {item.name}
                                  </option>
                                ))}
                              </select>
                              <label htmlFor="room_id">Select Room</label>
                              {errors.room_id && (
                                <div style={{ color: "red" }}>
                                  {errors.room_id[0]}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="col-md-12">
                            <div className="form-floating">
                              <select
                                className="form-select"
                                id="paymenttype"
                                value={formData.paymenttype}
                                onChange={handleChange}
                              >
                                <option value={0}>Please select</option>
                                <option value={1}>Online Payment</option>
                                <option value={2}>Offline Payment</option>
                              </select>

                              <label htmlFor="paymenttype">Payment Type</label>
                              {errors.paymenttype && (
                                <div style={{ color: "red" }}>
                                  {errors.paymenttype[0]}
                                </div>
                              )}
                            </div>
                          </div>

                          <div className="col-12">
                            <div className="form-floating">
                              <textarea
                                className="form-control"
                                placeholder="Special Request"
                                id="message"
                                value={formData.message}
                                onChange={handleChange}
                                style={{ height: 100 }}
                              ></textarea>
                              <label htmlFor="message">Special Request</label>
                            </div>
                          </div>

                          <div className="col-12">
                            <button
                              className="btn btn-primary w-100 py-3 shadow"
                              type="submit"
                              disabled={guestloading}
                            >
                              {guestloading ? (
                                <span>
                                  Loading... {countdown > 0 && `${countdown}`}
                                </span>
                              ) : (
                                "Book Now"
                              )}
                            </button>
                          </div>
                        </div>
                      </form>
                    </div>

                    {/* END */}
                  </div>

                  {/* END */}
                </div>
                <div className="modal-footer">
                  <button
                    type="button"
                    onClick={modalBookingCose}
                    className="btn btn-danger"
                    data-dismiss="modal"
                  >
                    Close
                  </button>
                </div>
              </div>
            </div>
          </div>

          {/* END Modal */}

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

export default RoomList;
