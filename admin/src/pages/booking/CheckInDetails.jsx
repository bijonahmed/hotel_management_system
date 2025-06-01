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
import { useSearchParams } from "react-router-dom";
import AuthUser from "../../components/AuthUser";

const CheckInDetails = () => {
  const [errors, setErrors] = useState({});
  const { getToken, token, logout, http, setToken } = AuthUser();
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const booking_id = searchParams.get("booking_id");
  const [roomData, setRoomData] = useState([]);
  //console.log("Received booking_id:", booking_id);

  const [preview, setPreview] = useState({
    front: null,
    back: null,
  });

  const handleFileChange = (e, type) => {
    const file = e.target.files[0];
    if (file) {
      setBooking((prev) => ({
        ...prev,
        [type]: file,
      }));

      setPreview((prev) => ({
        ...prev,
        [type === "front_side_document" ? "front" : "back"]:
          URL.createObjectURL(file),
      }));
    }
  };

  const [booking, setBooking] = useState({
    checkin: "",
    checkout: "",
    customer_dob: "",
    booking_type: "",
    booking_reference_no: "",
    pupose_of_visit: "",
    remarks: "",
    arival_from: "",
    room_id: "",
    room_no: "",
    adult: "",
    child: "",
    country_code: "88",
    phone: "",
    customer_title: "",
    customer_first_name: "",
    customer_last_name: "",
    customer_father_name: "",
    customer_gender: "",
    customer_occupation: "",
    customer_nationality: "Bangladeshi",
    customer_contact_type: "",
    customer_contact_email: "",
    customer_contact_address: "",
    total_booking_days: "",
    room_price: "",
    advance_amount: "",
    total_amount: "",
    id_no: "",
    front_side_document: null,
    back_side_document: null,
  });

  const handleSubmit = async (e) => {
    e.preventDefault(); // Prevent page reload

    const formData = new FormData();
    for (const key in booking) {
      //console.log(`${key}:`, booking[key]);
      formData.append(key, booking[key]);
    }
    formData.append("booking_id", booking_id);

    try {
      const res = await axios.post("/booking/updateCheckInDetails", formData, {
        headers: {
          Authorization: `Bearer ${token}`, // make sure `token` is defined
          "Content-Type": "multipart/form-data",
        },
      });
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
        title: "Successfully update.",
      });
      navigate(`/booking/checking-preview?booking_id=${booking_id}`);
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

  const fetechData = async () => {
    setLoading(true);
    try {
      const response = await axios.get("/booking/checkBookingRow", {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
        params: {
          bookingId: booking_id, // replace this with your actual variable or value
        },
      });
      console.log("API Response room_id:", response.data.booking_data.room_id); // Log the response

      const bookingData = response.data.booking_data;
      setPreview({
        front: response.data.front || null,
        back: response.data.back || null,
      });
      // const bookingBackImg  = response.data.booking_back;
      setBooking({
        checkin: formatDate(bookingData.checkin),
        checkout: formatDate(bookingData.checkout),
        customer_dob: formatDate(bookingData.customer_dob),
        booking_type: bookingData.booking_type || "",
        booking_reference_no: bookingData.booking_reference_no || "",
        pupose_of_visit: bookingData.pupose_of_visit || "",
        remarks: bookingData.remarks || "",
        arival_from: bookingData.arival_from || "",
        room_id: bookingData.room_id || "",
        room_no: bookingData.room_no || "",
        adult: bookingData.adult || "",
        child: bookingData.child || "",
        country_code: bookingData.country_code || "",
        phone: bookingData.phone || "",
        customer_title: bookingData.customer_title || "",
        customer_first_name: bookingData.customer_first_name || "",
        customer_last_name: bookingData.customer_last_name || "",
        customer_father_name: bookingData.customer_father_name || "",
        customer_gender: bookingData.customer_gender || "",
        customer_occupation: bookingData.customer_occupation || "",
        customer_nationality: bookingData.customer_nationality || "",
        customer_contact_type: bookingData.customer_contact_type || "",
        customer_contact_email: bookingData.customer_contact_email || "",
        customer_contact_address: bookingData.customer_contact_address || "",
        total_booking_days: bookingData.total_booking_days || "",
        // front_side_document: bookingFrontImg || "",
        // back_side_document: bookingBackImg || "",
        id_no: bookingData.id_no || "",
        room_price: bookingData.room_price || "0.00",
        total_amount: response.data.total_amount || "0.00",
        advance_amount: bookingData.advance_amount || "",
      });
    } catch (error) {
      console.error("Error fetching data", error);
    } finally {
      setLoading(false);
    }
  };

  const formatBookingTotal = (price, days) => {
    const total = price * days;
    return total.toLocaleString("en-US", {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    });
  };

  const fetechActiveRooms = async () => {
    try {
      const response = await axios.get(`/public/allActiveRooms`);
      console.log("API Room Response:", response.data); // Log the response
      setRoomData(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    }
  };

  const formatDate = (dateStr) => {
    if (!dateStr) return "";
    return new Date(dateStr).toISOString().split("T")[0]; // "2024-09-01"
  };

  useEffect(() => {
    fetechData();
    fetechActiveRooms();
  }, []);

  return (
    <>
      <Helmet>
        <title>Check In Details</title>
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
                <div className="breadcrumb-title pe-3">
                  Fill Out Booking Details
                </div>
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
                        <Link to="/booking/checkin-list">Back</Link>
                      </li>
                    </ol>
                  </nav>
                </div>
              </div>

              <div className="">
                <div className="">
                  <div className="container-fluid">
                    {/* Start */}

                    {loading && (
                      <div className="text-center my-3">
                        <div
                          className="spinner-border text-primary"
                          role="status"
                        >
                          <span className="visually-hidden">Loading...</span>
                        </div>
                      </div>
                    )}

                    <form onSubmit={handleSubmit}>
                      <div className="page-body">
                        <div className="row g-3">
                          <div className="col-sm-12">
                            <div className="card mb-3">
                              <div className="card-header">
                                <h6 className="card-title">
                                  Reservation Details
                                </h6>
                              </div>
                              <div className="card-body">
                                <div className="row g-3">
                                  <center>
                                    <b></b>Total Number of day checkin:{" "}
                                    <b>{booking.total_booking_days}</b>
                                  </center>
                                  <div className="col-md-6 col-lg-4 col-xl-4">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Check In{" "}
                                        <span className="text-danger">*</span>
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-calendar-plus" />
                                        </span>
                                        <input
                                          type="date"
                                          className="form-control"
                                          value={booking.checkin || ""}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              checkin: e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6 col-lg-4 col-xl-4">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Check Out
                                        <span className="text-danger">*</span>
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-calendar-minus" />
                                        </span>
                                        <input
                                          type="date"
                                          className="form-control"
                                          value={booking.checkout}
                                         
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              checkout: e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6 col-lg-4 col-xl-4">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Arival From
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-stop-circle" />
                                        </span>

                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="Arival From"
                                          value={booking.arival_from}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              arival_from: e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6 col-lg-4 col-xl-4">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Booking Type
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-house" />
                                        </span>
                                        <select
                                          className="form-select"
                                          value={booking.booking_type}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              booking_type: e.target.value,
                                            })
                                          }
                                        >
                                          <option value="">
                                            Choose Booking Reference
                                          </option>
                                          <option value="Advance">
                                            Advance
                                          </option>
                                          <option value="Instant">
                                            Instant
                                          </option>
                                          <option value="Groups">Groups</option>
                                          <option value="Allocation">
                                            Allocation
                                          </option>
                                          <option value="Business Seminar">
                                            Business Seminar
                                          </option>
                                          <option value="Wedding">
                                            Wedding
                                          </option>
                                          <option value="Others">Others</option>
                                        </select>
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6 col-lg-4 col-xl-4">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Booking Reference No
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-bookmark-heart" />
                                        </span>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="Booking Reference No."
                                          value={booking.booking_reference_no}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              booking_reference_no:
                                                e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6 col-lg-4 col-xl-4">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Purpose of Visit
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-eyeglasses" />
                                        </span>

                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="Purpose of Visit"
                                          value={booking.pupose_of_visit}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              pupose_of_visit: e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-12 col-lg-12 col-xl-12">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Remarks
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-bookmark-star" />
                                        </span>

                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="Remarks"
                                          value={booking.remarks}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              remarks: e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <div className="card mb-3">
                              <div className="card-header">
                                <h6 className="card-title">Room Details</h6>
                              </div>
                              <div className="card-body">
                                <div className="row g-3">
                                  <div className="col-md-6">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Room Name{" "}
                                        <span className="text-danger">*</span>
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-house" />
                                        </span>
                                        <select
                                          className="form-select"
                                          id="room_id"
                                          value={booking.room_id || ""} // Fallback to empty string
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              room_id: e.target.value, // Make sure to set as string or convert to number as needed
                                            })
                                          }
                                        >
                                          <option value="">
                                            Please select  
                                          </option>
                                          {roomData.length > 0 &&
                                            roomData.map((item, index) => (
                                              <option
                                                key={index}
                                                value={item.id}
                                              >
                                                {item.name} 
                                              </option>
                                            ))}
                                        </select>

                                        {errors.room_id && (
                                          <div style={{ color: "red" }}>
                                            {errors.room_id[0]}
                                          </div>
                                        )}
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Room No
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-house" />
                                        </span>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="Room No"
                                          value={booking.room_no}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              room_no: e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Adults
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-people" />
                                        </span>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="Adult"
                                          value={booking.adult}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              adult: e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Children
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-person" />
                                        </span>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="Child"
                                          value={booking.child}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              child: e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <div className="card">
                              <div className="card-header">
                                <h6 className="card-title">Customer Details</h6>
                              </div>
                              <div className="card-body">
                                <div className="row g-3">
                                  <div className="col-md-12 col-lg-6 d-flex">
                                    <div className="card flex-fill w-100 border">
                                      <div className="card-header py-3">
                                        <h6 className="card-title">
                                          Guest Details
                                        </h6>
                                      </div>
                                      <div className="card-body">
                                        <div className="row g-3">
                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Country Code
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-geo-alt" />
                                                </span>

                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="Country Code"
                                                  value={booking.country_code}
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      country_code:
                                                        e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>
                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Mobile No.
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-phone" />
                                                </span>
                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="Mobile No."
                                                  value={booking.phone}
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      phone: e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>
                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Title
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-emoji-smile" />
                                                </span>

                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="Title"
                                                  value={booking.customer_title}
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      customer_title:
                                                        e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>
                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                First Name{" "}
                                                <span className="text-danger">
                                                  *
                                                </span>
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-person-circle" />
                                                </span>

                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="First Name"
                                                  value={
                                                    booking.customer_first_name
                                                  }
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      customer_first_name:
                                                        e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>
                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Last Name
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-person-circle" />
                                                </span>
                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="Last Name"
                                                  value={
                                                    booking.customer_last_name
                                                  }
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      customer_last_name:
                                                        e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>
                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Father Name
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-person-circle" />
                                                </span>
                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="Father Name"
                                                  value={
                                                    booking.customer_father_name
                                                  }
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      customer_father_name:
                                                        e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>
                                          <div className="col-md-6 align-self-center">
                                            <label className="form-label text-muted w-100">
                                              Gender
                                            </label>

                                            <div className="form-check form-check-inline">
                                              <input
                                                className="form-check-input"
                                                type="radio"
                                                name="customer_gender"
                                                id="inlineRadio1"
                                                value="Male"
                                                checked={
                                                  booking.customer_gender ===
                                                  "Male"
                                                }
                                                onChange={(e) =>
                                                  setBooking({
                                                    ...booking,
                                                    customer_gender:
                                                      e.target.value,
                                                  })
                                                }
                                              />
                                              <label
                                                className="form-check-label"
                                                htmlFor="inlineRadio1"
                                              >
                                                Male
                                              </label>
                                            </div>

                                            <div className="form-check form-check-inline">
                                              <input
                                                className="form-check-input"
                                                type="radio"
                                                name="customer_gender"
                                                id="inlineRadio2"
                                                value="Female"
                                                checked={
                                                  booking.customer_gender ===
                                                  "Female"
                                                }
                                                onChange={(e) =>
                                                  setBooking({
                                                    ...booking,
                                                    customer_gender:
                                                      e.target.value,
                                                  })
                                                }
                                              />
                                              <label
                                                className="form-check-label"
                                                htmlFor="inlineRadio2"
                                              >
                                                Female
                                              </label>
                                            </div>
                                          </div>

                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Occupation
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-briefcase" />
                                                </span>

                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="Occupation"
                                                  value={
                                                    booking.customer_occupation
                                                  }
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      customer_occupation:
                                                        e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>
                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Date of Birth
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-calendar" />
                                                </span>
                                                <input
                                                  type="date"
                                                  className="form-control"
                                                  value={booking.customer_dob}
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      customer_dob:
                                                        e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>

                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Nationality
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-geo-alt" />
                                                </span>
                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="Nationality"
                                                  value={
                                                    booking.customer_nationality
                                                  }
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      customer_nationality:
                                                        e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-12 col-lg-6 d-flex">
                                    <div className="card flex-fill w-100 border">
                                      <div className="card-header py-3">
                                        <h6 className="card-title">
                                          Contact Details
                                        </h6>
                                      </div>
                                      <div className="card-body">
                                        <div className="row g-3">
                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Contact Type
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-journal" />
                                                </span>
                                                <select
                                                  className="form-select"
                                                  value={
                                                    booking.customer_contact_type
                                                  }
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      customer_contact_type:
                                                        e.target.value,
                                                    })
                                                  }
                                                >
                                                  <option value="">
                                                    Choose Contact Type
                                                  </option>
                                                  <option value="Home">
                                                    Home
                                                  </option>
                                                  <option value="Personal">
                                                    Personal
                                                  </option>
                                                  <option value="Official">
                                                    Official
                                                  </option>
                                                  <option value="Business">
                                                    Business
                                                  </option>
                                                  <option value="Others">
                                                    Others
                                                  </option>
                                                </select>
                                              </div>
                                            </div>
                                          </div>
                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Email
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-envelope" />
                                                </span>
                                                <input
                                                  type="email"
                                                  className="form-control"
                                                  placeholder="Email"
                                                  value={
                                                    booking.customer_contact_email
                                                  }
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      customer_contact_email:
                                                        e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>

                                          <div className="col-md-12 mb-3">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Address
                                              </label>
                                              <textarea
                                                className="form-control"
                                                placeholder="Address"
                                                value={
                                                  booking.customer_contact_address
                                                }
                                                onChange={(e) =>
                                                  setBooking({
                                                    ...booking,
                                                    customer_contact_address:
                                                      e.target.value,
                                                  })
                                                }
                                                rows={12}
                                              />
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-12 col-lg-12 d-flex">
                                    <div className="card flex-fill w-100 border">
                                      <div className="card-header py-3">
                                        <h6 className="card-title">
                                          Identity Details
                                        </h6>
                                      </div>
                                      <div className="card-body">
                                        <div className="row g-3">
                                          <div className="col-md-12">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                ID #{" "}
                                                <span className="text-danger">
                                                  *
                                                </span>
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-images" />
                                                </span>
                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="ID"
                                                  value={booking.id_no}
                                                  onChange={(e) =>
                                                    setBooking({
                                                      ...booking,
                                                      id_no: e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>
                                          <div className="col-md-12">
                                            <label>Identity Upload</label>
                                          </div>

                                          <div className="row">
                                            {/* Left Side - Front Side Document */}
                                            <div className="col-md-6">
                                              <div className="form-group">
                                                <label className="form-label text-muted">
                                                  Front Side Document
                                                </label>
                                                <div className="input-group">
                                                  <span className="input-group-text">
                                                    <i className="bi bi-images" />
                                                  </span>
                                                  <input
                                                    type="file"
                                                    className="form-control"
                                                    onChange={(e) =>
                                                      handleFileChange(
                                                        e,
                                                        "front_side_document"
                                                      )
                                                    }
                                                  />
                                                </div>
                                                {preview.front && (
                                                  <img
                                                    src={preview.front}
                                                    alt="Front Preview"
                                                    className="mt-2"
                                                    style={{ height: 100 }}
                                                  />
                                                )}
                                              </div>
                                            </div>

                                            {/* Right Side - Back Side Document */}
                                            <div className="col-md-6">
                                              <div className="form-group">
                                                <label className="form-label text-muted">
                                                  Back Side Document
                                                </label>
                                                <div className="input-group">
                                                  <span className="input-group-text">
                                                    <i className="bi bi-images" />
                                                  </span>
                                                  <input
                                                    type="file"
                                                    className="form-control"
                                                    onChange={(e) =>
                                                      handleFileChange(
                                                        e,
                                                        "back_side_document"
                                                      )
                                                    }
                                                  />
                                                </div>
                                                {preview.back && (
                                                  <img
                                                    src={preview.back}
                                                    alt="Back Preview"
                                                    className="mt-2"
                                                    style={{ height: 100 }}
                                                  />
                                                )}
                                              </div>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>

                          <div className="col-md-12 col-lg-12">
                            <div className="card">
                              <div className="card-header">
                                <h6 className="card-title">Advance Details</h6>
                              </div>
                              <div className="card-body">
                                <div className="row g-3">
                                  <div className="col-md-6">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Payment Mode
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-credit-card" />
                                        </span>
                                        <select className="form-select">
                                          <option value="Card Payment">
                                            Card Payment
                                          </option>
                                          <option value="Cash Payment">
                                            Cash Payment
                                          </option>
                                          <option value="Bank Payment">
                                            Bank Payment
                                          </option>
                                        </select>
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Total Amount
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-currency-dollar" />
                                        </span>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="0.00"
                                          value={booking.total_amount}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              total_amount: e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div className="col-md-6">
                                    <div className="card bg-light border-primary p-3">
                                      <div className="card-body">
                                        <h5 className="card-title text-primary">
                                          Check-in Summary
                                        </h5>
                                        <p className="mb-1">
                                          <strong>
                                            Total number of check-in days:
                                          </strong>{" "}
                                          {booking.total_booking_days}
                                        </p>
                                        <p className="mb-1">
                                          <strong>Per day room price:</strong>{" "}
                                          {booking.room_price} TK
                                        </p>
                                        <p className="mb-0">
                                          <strong>Total Amount:</strong>{" "}
                                          {formatBookingTotal(
                                            booking.room_price,
                                            booking.total_booking_days
                                          )}{" "}
                                          TK
                                        </p>
                                      </div>
                                    </div>
                                  </div>

                                  <div className="col-md-6">
                                    <div className="form-group">
                                      <label className="form-label text-muted">
                                        Advance Amount
                                      </label>
                                      <div className="input-group">
                                        <span className="input-group-text">
                                          <i className="bi bi-currency-dollar" />
                                        </span>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="0.00"
                                          value={booking.advance_amount}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              advance_amount: e.target.value,
                                            })
                                          }
                                        />
                                      </div>
                                    </div>
                                  </div>

                                  <div className="col-md-6"></div>
                                  <div className="col-md-6 d-grid gap-2 d-md-block">
                                    <button
                                      type="submit"
                                      className="btn btn-primary w-100"
                                      disabled={loading} // disable during loading
                                    >
                                      {loading ? "Submitting..." : "Submit"}
                                    </button>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        {/* Row End */}
                      </div>
                    </form>

                    {/* END */}
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

export default CheckInDetails;
