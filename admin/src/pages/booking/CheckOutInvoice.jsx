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

const CheckOutInvoice = () => {
  const [errors, setErrors] = useState({});
  const { getToken, token, logout, http, setToken } = AuthUser();
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const booking_id = searchParams.get("booking_id");
  const [roomData, setRoomData] = useState([]);
  console.log("Received booking_id:", booking_id);

  const [preview, setPreview] = useState({
    front: null,
    back: null,
  });

  const [booking, setBooking] = useState({
    booking_id: "",
    checkin: "",
    checkout: "",
    customer_dob: "",
    booking_type: "",
    booking_reference_no: "",
    pupose_of_visit: "",
    remarks: "",
    arival_from: "",
    room_id: "",
    room_name: "",
    room_no: "",
    adult: "",
    child: "",
    country_code: "88",
    phone: "",
    total_booking_days: "",
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
    room_price: "",
    perday_roomprice: "",
    advance_amount: "",
    id_no: "",
    front_side_document: null,
    back_side_document: null,
  });

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
      console.log("API Response:", response.data.booking_front); // Log the response

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
        booking_id: bookingData.booking_id || "",
        booking_reference_no: bookingData.booking_reference_no || "",
        pupose_of_visit: bookingData.pupose_of_visit || "",
        remarks: bookingData.remarks || "",
        arival_from: bookingData.arival_from || "",
        room_id: bookingData.room_id || "",
        room_name: bookingData.room_name || "",
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
        perday_roomprice: bookingData.perday_roomprice || "0.00",
        // front_side_document: bookingFrontImg || "",
        // back_side_document: bookingBackImg || "",
        id_no: bookingData.id_no || "",
        room_price: bookingData.room_price || "0.00",
        advance_amount: bookingData.advance_amount || "0.00",
      });
    } catch (error) {
      console.error("Error fetching data", error);
    } finally {
      setLoading(false);
    }
  };

  const formatDate = (dateStr) => {
    if (!dateStr) return "";
    return new Date(dateStr).toISOString().split("T")[0]; // "2024-09-01"
  };
  const renderRow = (label, value, colSpan = 1) => (
    <tr key={label}>
      <th style={{ width: "25%" }}>{label}</th>
      <td colSpan={colSpan}>{value || "N/A"}</td>
    </tr>
  );

  useEffect(() => {
    fetechData();
    // fetechActiveRooms();
  }, []);

  return (
    <>
      <Helmet>
        <title>Check Out Invoice</title>
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
                        <Link to="/booking/checkout-list">Back</Link>
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

                    <div className="card">
                      <div className="card-header">
                        <ul
                          className="nav nav-tabs card-header-tabs"
                          id="bookingTabs"
                          role="tablist"
                        >
                          <li className="nav-item" role="presentation">
                            <button
                              className="nav-link active"
                              id="invoice-tab"
                              data-bs-toggle="tab"
                              data-bs-target="#invoice"
                              type="button"
                              role="tab"
                              aria-controls="invoice"
                              aria-selected="true"
                            >
                              Invoice
                            </button>
                          </li>
                          <li className="nav-item" role="presentation">
                            <button
                              className="nav-link"
                              id="booking-tab"
                              data-bs-toggle="tab"
                              data-bs-target="#booking"
                              type="button"
                              role="tab"
                              aria-controls="booking"
                              aria-selected="false"
                            >
                              Booking Particular
                            </button>
                          </li>
                        </ul>
                      </div>
                      <div className="card-body">
                        <div className="tab-content" id="bookingTabsContent">
                          {/* Invoice Tab */}
                          <div
                            className="tab-pane fade show active"
                            id="invoice"
                            role="tabpanel"
                            aria-labelledby="invoice-tab"
                          >
                            {/* INSERT INVOICE CONTENT HERE */}

                            <div className="card mb-3">
                              <div className="card-header">
                                <h6 className="card-title">Invoice</h6>
                              </div>
                              <div className="card-body">
                                {/* Start */}
                                <table className="table table-bordered">
                                  <thead>
                                    <tr>
                                      <th>#</th>
                                      <th>Item Name</th>
                                      <th>Quantity</th>
                                      <th>Unit Price (TK)</th>
                                      <th>Total (TK)</th>
                                      <th>Action</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {/* Static example row */}
                                    <tr>
                                      <td>1</td>
                                      <td>Water Bottle</td>
                                      <td>2</td>
                                      <td>20</td>
                                      <td>40</td>
                                      <td>
                                        <button className="btn btn-sm btn-danger">
                                          Remove
                                        </button>
                                      </td>
                                    </tr>
                                    {/* Another example row */}
                                    <tr>
                                      <td>2</td>
                                      <td>Extra Bed</td>
                                      <td>1</td>
                                      <td>500</td>
                                      <td>500</td>
                                      <td>
                                        <button className="btn btn-sm btn-danger">
                                          Remove
                                        </button>
                                      </td>
                                    </tr>
                                    {/* Add item input row */}
                                    <tr>
                                      <td>#</td>
                                      <td>
                                        <select className="form-control">
                                          <option value>Select item</option>
                                          <option value="Water Bottle">
                                            Water Bottle
                                          </option>
                                          <option value="Extra Bed">
                                            Extra Bed
                                          </option>
                                          <option value="Room Service">
                                            Room Service
                                          </option>
                                        </select>
                                      </td>
                                      <td>
                                        <input
                                          type="number"
                                          className="form-control"
                                          placeholder="Qty"
                                        />
                                      </td>
                                      <td>
                                        <input
                                          type="number"
                                          className="form-control"
                                          placeholder="Price"
                                        />
                                      </td>
                                      <td>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="Total"
                                          disabled
                                        />
                                      </td>
                                      <td>
                                        <button className="btn btn-sm btn-success">
                                          Add
                                        </button>
                                      </td>
                                    </tr>
                                  </tbody>
                                </table>

                                {/* END */}

                                <table className="table table-bordered">
                                  <thead>
                                    <tr>
                                      <th>#</th>
                                      <th>Room Name</th>
                                      <th>Check-In</th>
                                      <th>Check-Out</th>
                                      <th className="text-center">Days</th>
                                      <th>Price / Day</th>
                                      <th>Total Room Price</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    <tr>
                                      <td>1</td>
                                      <td>{booking.room_name}</td>
                                      <td>{booking.checkin}</td>
                                      <td>{booking.checkout}</td>
                                      <td className="text-center">
                                        {booking.total_booking_days}
                                      </td>
                                      <td>{booking.perday_roomprice}</td>
                                    <td>
  {booking.perday_roomprice} x {booking.total_booking_days} =  { (booking.perday_roomprice * booking.total_booking_days).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) } TK
</td>
                                    </tr>
                                  </tbody>
                                  <tfoot>
                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Subtotal
                                      </th>
                                      <td>
                                       { (booking.perday_roomprice * booking.total_booking_days).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) } TK
                                      </td>
                                    </tr>
                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Tax (2)%
                                      </th>
                                      <td>
                                       1,171.68 Tk.
                                      </td>
                                    </tr>
                                      <tr>
                                      <th colSpan={6} className="text-end">
                                        Item Total
                                      </th>
                                      <td>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="0.00"
                                        />
                                      </td>
                                    </tr>
                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Discount
                                      </th>
                                      <td>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="0.00"
                                        />
                                      </td>
                                    </tr>
                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Advance Paid
                                      </th>
                                      <td>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="0.00"
                                        />
                                      </td>
                                    </tr>
                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        <strong>Grand Total</strong>
                                      </th>
                                      <td>
                                         { (booking.perday_roomprice * booking.total_booking_days).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) } TK
                                      </td>
                                    </tr>
                                  </tfoot>
                                </table>
                              </div>
                            </div>
                          </div>

                          {/* Booking Particular Tab */}
                          <div
                            className="tab-pane fade"
                            id="booking"
                            role="tabpanel"
                            aria-labelledby="booking-tab"
                          >
                            {/* INSERT YOUR PROVIDED BOOKING DETAILS HERE */}
                            <div className="page-body">
                              <div className="row g-3">
                                <div className="col-sm-12">
                                  {/* Reservation Details */}
                                  <div className="card mb-3">
                                    <div className="card-header">
                                      <h6 className="card-title">
                                        Reservation Details
                                      </h6>
                                    </div>
                                    <div className="card-body">
                                      <div className="row g-3">
                                        <table className="table table-bordered">
                                          <tbody>
                                            {renderRow(
                                              "Booking ID",
                                              booking.booking_id
                                            )}
                                            {renderRow(
                                              "Booking Type",
                                              booking.booking_type
                                            )}
                                            {renderRow(
                                              "Booking Reference No",
                                              booking.booking_reference_no
                                            )}
                                            {renderRow(
                                              "Purpose of Visit",
                                              booking.pupose_of_visit
                                            )}
                                            {renderRow(
                                              "Remarks",
                                              booking.remarks
                                            )}
                                            {renderRow(
                                              "Arrival From",
                                              booking.arival_from
                                            )}
                                            {renderRow(
                                              "Check In",
                                              booking.checkin
                                            )}
                                            {renderRow(
                                              "Check Out",
                                              booking.checkout
                                            )}
                                            {renderRow(
                                              "Room Name",
                                              booking.room_name
                                            )}
                                            {renderRow(
                                              "Room No",
                                              booking.room_no
                                            )}
                                            {renderRow("Adult", booking.adult)}
                                            {renderRow("Child", booking.child)}
                                          </tbody>
                                        </table>
                                      </div>
                                    </div>
                                  </div>

                                  {/* Identity Details */}
                                  <div className="card mb-3">
                                    <div className="card-header">
                                      <h6 className="card-title">
                                        Identity Details
                                      </h6>
                                    </div>
                                    <div className="card-body">
                                      <table className="table table-bordered">
                                        <tbody>
                                          {renderRow(
                                            "Title",
                                            booking.customer_title
                                          )}
                                          {renderRow(
                                            "First Name",
                                            booking.customer_first_name
                                          )}
                                          {renderRow(
                                            "Last Name",
                                            booking.customer_last_name
                                          )}
                                          {renderRow(
                                            "Father's Name",
                                            booking.customer_father_name
                                          )}
                                          {renderRow(
                                            "Gender",
                                            booking.customer_gender
                                          )}
                                          {renderRow(
                                            "Date of Birth",
                                            booking.customer_dob
                                          )}
                                          {renderRow(
                                            "Occupation",
                                            booking.customer_occupation
                                          )}
                                          {renderRow(
                                            "Nationality",
                                            booking.customer_nationality
                                          )}
                                          {renderRow(
                                            "Contact Type",
                                            booking.customer_contact_type
                                          )}
                                          {renderRow(
                                            "Contact Email",
                                            booking.customer_contact_email
                                          )}
                                          {renderRow(
                                            "Contact Address",
                                            booking.customer_contact_address
                                          )}
                                          {renderRow(
                                            "Room Amount",
                                            booking.room_price
                                          )}
                                          {renderRow(
                                            "Advance Amount",
                                            booking.advance_amount
                                          )}
                                          {renderRow(
                                            "Country Code",
                                            booking.country_code
                                          )}
                                          {renderRow("Phone", booking.phone)}
                                          {renderRow("ID No", booking.id_no)}
                                        </tbody>
                                      </table>
                                    </div>
                                  </div>
                                </div>

                                {/* Document Preview */}
                                <div className="col-md-12 col-lg-12">
                                  <div className="card">
                                    <div className="card-header">
                                      <h6 className="card-title">
                                        Document Preview
                                      </h6>
                                    </div>
                                    <div className="card-body">
                                      <table
                                        className="print-table"
                                        style={{
                                          width: "100%",
                                          borderCollapse: "collapse",
                                        }}
                                      >
                                        <thead>
                                          <tr>
                                            <th
                                              style={{
                                                textAlign: "center",
                                                paddingBottom: "10px",
                                              }}
                                            >
                                              Front Side Document
                                            </th>
                                            <th
                                              style={{
                                                textAlign: "center",
                                                paddingBottom: "10px",
                                              }}
                                            >
                                              Back Side Document
                                            </th>
                                          </tr>
                                        </thead>
                                        <tbody>
                                          <tr>
                                            <td style={{ textAlign: "center" }}>
                                              {preview.front ? (
                                                <img
                                                  src={preview.front}
                                                  alt="Front"
                                                  className="print-img"
                                                  style={{ height: "100px" }}
                                                />
                                              ) : (
                                                <p>
                                                  No front side document
                                                  available
                                                </p>
                                              )}
                                            </td>
                                            <td style={{ textAlign: "center" }}>
                                              {preview.back ? (
                                                <img
                                                  src={preview.back}
                                                  alt="Back"
                                                  className="print-img"
                                                  style={{ height: "100px" }}
                                                />
                                              ) : (
                                                <p>
                                                  No back side document
                                                  available
                                                </p>
                                              )}
                                            </td>
                                          </tr>
                                        </tbody>
                                      </table>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            {/* End of Booking Particular */}
                          </div>
                        </div>
                      </div>
                    </div>

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

export default CheckOutInvoice;
