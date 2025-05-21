import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link, useNavigate, useSearchParams } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import axios from "/config/axiosConfig";
import Swal from "sweetalert2";
import AuthUser from "../../components/AuthUser";
import "../../components/css/CheckInPreview.css";

const CheckInPreview = () => {
  const [errors, setErrors] = useState({});
  const { token } = AuthUser();
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const booking_id = searchParams.get("booking_id");
  const [roomData, setRoomData] = useState([]);

  const [preview, setPreview] = useState({
    front: null,
    back: null,
  });

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
    booking_id: "",
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
    room_price: "",
    advance_amount: "",
    id_no: "",
    front_side_document: null,
    back_side_document: null,
  });

  // Format date to yyyy-mm-dd
  const formatDate = (dateStr) => {
    if (!dateStr) return "";
    return new Date(dateStr).toISOString().split("T")[0];
  };
  const formatCurrency = (value) => {
    return new Intl.NumberFormat("en-US", {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    }).format(parseFloat(value || "0.00"));
  };
  // Fetch booking data
  const fetchData = async () => {
    setLoading(true);
    try {
      const response = await axios.get("/booking/checkBookingRow", {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
        params: { bookingId: booking_id },
      });

      const bookingData = response.data.booking_data;
      setPreview({
        front: response.data.front || null,
        back: response.data.back || null,
      });

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
        room_no: bookingData.room_no || "",
        adult: bookingData.adult || "",
        child: bookingData.child || "",
        country_code: bookingData.country_code || "88",
        phone: bookingData.phone || "",
        customer_title: bookingData.customer_title || "",
        customer_first_name: bookingData.customer_first_name || "",
        customer_last_name: bookingData.customer_last_name || "",
        customer_father_name: bookingData.customer_father_name || "",
        customer_gender: bookingData.customer_gender || "",
        customer_occupation: bookingData.customer_occupation || "",
        customer_nationality: bookingData.customer_nationality || "Bangladeshi",
        customer_contact_type: bookingData.customer_contact_type || "",
        customer_contact_email: bookingData.customer_contact_email || "",
        customer_contact_address: bookingData.customer_contact_address || "",
        id_no: bookingData.id_no || "",
        room_price: formatCurrency(bookingData.room_price) || "0.00",
        advance_amount: formatCurrency(bookingData.advance_amount) || "0.00",
        front_side_document: null,
        back_side_document: null,
      });
    } catch (error) {
      console.error("Error fetching booking data:", error);
      Swal.fire("Error", "Failed to fetch booking data", "error");
    } finally {
      setLoading(false);
    }
  };

  // Fetch active rooms data
  const fetchActiveRooms = async () => {
    try {
      const response = await axios.get("/public/activeRooms");
      setRoomData(response.data);
    } catch (error) {
      console.error("Error fetching active rooms:", error);
    }
  };

  const handlePrintPreview = () => {
    const element = document.getElementById("printArea");
    if (!element) return;

    const printWindow = window.open("", "", "width=800,height=600");
    printWindow.document.write(`
    <html>
      <head>
        <title>Print Preview</title>
        <style>
          /* Include your styles here if needed */
          body { font-family: Arial, sans-serif; margin: 20px; }
          table { border-collapse: collapse; width: 100%; }
          table, th, td { border: 1px solid black; }
          th, td { padding: 2px; text-align: left; }
          img { max-height: 300px; }
        </style>
      </head>
      <body>
        ${element.innerHTML}
      </body>
    </html>
  `);

    printWindow.document.close();
    printWindow.focus();

    // Wait for content to load before printing
    printWindow.onload = () => {
      printWindow.print();
      printWindow.close();
    };
  };

  // Helper to render a table row
  const renderRow = (label, value, colSpan = 1) => (
    <tr key={label}>
      <th style={{ width: "25%" }}>{label}</th>
      <td colSpan={colSpan}>{value || "N/A"}</td>
    </tr>
  );

  useEffect(() => {
    fetchData();
    fetchActiveRooms();
  }, []);

  return (
    <>
      <Helmet>
        <title>Check In Preview</title>
      </Helmet>

      <div className="wrapper">
        <LeftSideBarComponent />

        <header>
          <GuestNavbar />
        </header>

        <div className="page-wrapper">
          <div className="page-content">
            {/* Breadcrumb */}
            <div className="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
              <div className="breadcrumb-title pe-3">
                Preview Booking Details
              </div>
              <div className="ps-3">
                <nav aria-label="breadcrumb">
                  <ol className="breadcrumb mb-0 p-0">
                    <li className="breadcrumb-item">
                      <Link to="/dashboard">
                        <i className="bx bx-home-alt" />
                      </Link>
                    </li>
                    <li className="breadcrumb-item active" aria-current="page">
                      <Link to="/booking/checkin-list">Back</Link>
                    </li>
                  </ol>
                </nav>
              </div>
            </div>

            {/* Print Button */}
            <center>
              <button
                className="btn btn-primary mb-4"
                onClick={handlePrintPreview}
              >
                <i className="fa fa-print"></i> Print Preview
              </button>
            </center>

            {/* Loader */}
            {loading && (
              <div className="text-center my-3">
                <div className="spinner-border text-primary" role="status">
                  <span className="visually-hidden">Loading...</span>
                </div>
              </div>
            )}


            {/* Booking Details Card */}
            <div className="container" id="printArea">
              <div className="card">
                <div className="card-body">
                  <section className="mb-4">
                    <h5 className="border-bottom">Reservation Details</h5>
                    <table className="table table-bordered">
                      <tbody>
                        {renderRow("Booking ID", booking.booking_id)}
                        {renderRow("Booking Type", booking.booking_type)}
                        {renderRow(
                          "Booking Reference No",
                          booking.booking_reference_no
                        )}
                        {renderRow("Purpose of Visit", booking.pupose_of_visit)}
                        {renderRow("Remarks", booking.remarks)}
                        {renderRow("Arrival From", booking.arival_from)}
                        {renderRow("Check In", booking.checkin)}
                        {renderRow("Check Out", booking.checkout)}
                        {renderRow("Room No", booking.room_no)}
                        {renderRow("Adult", booking.adult)}
                        {renderRow("Child", booking.child)}
                      </tbody>
                    </table>
                  </section>

                  {/* Identity Details */}
                  <section className="mb-4">
                    <h5 className="border-bottom pb-2">Identity Details</h5>
                    <table className="table table-bordered">
                      <tbody>
                        {renderRow("Title", booking.customer_title)}
                        {renderRow("First Name", booking.customer_first_name)}
                        {renderRow("Last Name", booking.customer_last_name)}
                        {renderRow(
                          "Father's Name",
                          booking.customer_father_name
                        )}
                        {renderRow("Gender", booking.customer_gender)}
                        {renderRow("Date of Birth", booking.customer_dob)}
                        {renderRow("Occupation", booking.customer_occupation)}
                        {renderRow("Nationality", booking.customer_nationality)}
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
                        {renderRow("Room Amount", booking.room_price)}
                        {renderRow("Advance Amount", booking.advance_amount)}
                        {renderRow("Country Code", booking.country_code)}
                        {renderRow("Phone", booking.phone)}
                        {renderRow("ID No", booking.id_no)}
                      </tbody>
                    </table>
                  </section>

                  {/* Document Preview */}
                  <section className="mb-4">
                    <h5 className="mb-3 border-bottom pb-2">
                      Document Preview
                    </h5>
                    <div className="document-print-row">
                      <table
                        className="print-table"
                        style={{ width: "100%", borderCollapse: "collapse" }}
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
                                <p>No front side document available</p>
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
                                <p>No back side document available</p>
                              )}
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </section>

                  {/* Upload New Documents */}
                </div>
              </div>
            </div>

            <Footer />
          </div>
        </div>
      </div>
    </>
  );
};

export default CheckInPreview;
