import React, { useState, useEffect, useRef } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import axios from "/config/axiosConfig";
import Swal from "sweetalert2";
import { useSearchParams } from "react-router-dom";
import AuthUser from "../../components/AuthUser";
import withReactContent from "sweetalert2-react-content";
import ReactDOMServer from "react-dom/server";
import "../../components/css/PrintCheckOutInvoice.css";
import { toWords } from "number-to-words";

const PrintCheckOutInvoice = () => {
  const navigate = useNavigate();
  const [errors, setErrors] = useState({});
  const { getToken, token, logout, http, setToken } = AuthUser();
  const [loading, setLoading] = useState(false);
  const [searchParams] = useSearchParams();
  const [itemData, setItemData] = useState([]);
  const [selectedItemId, setSelectedItemId] = useState("");
  const [qty, setQty] = useState("");
  const [price, setPrice] = useState("");
  const [itemGrandTotal, setGrandTotal] = useState(0);
  const [dueAmt, setDueAmount] = useState(0);
  const [addedItems, setAddedItems] = useState([]);
  const booking_id = searchParams.get("booking_id");
  //console.log("Received booking_id:", booking_id);
  const MySwal = withReactContent(Swal);
  const [discount_amt, setdiscountAmt] = useState("");
  const [bookingstatus, setBookingStatus] = useState("");
  const [finalDiscountAmt, setFinalDiscountAmt] = useState(0);
  const [settingData, setName] = useState({});
  const invoiceRef = useRef();

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
    tax_percentage: "",
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
      const bookingData = response.data.booking_data;
      setAddedItems(response.data.itemlist);
      setdiscountAmt(response.data.booking_data.discount_amount);
      setBookingStatus(bookingData.booking_status);

      if (!bookingData.id_no) {
        const alertHtml = ReactDOMServer.renderToString(
          <div>
            <p>Please first fill up check-in NID and other information.</p>
            <a
              href={`/booking/checking-details?booking_id=${bookingData.booking_id}`}
              className="text-primary"
            >
              👉 Go to Check-in List
            </a>
          </div>
        );
        MySwal.fire({
          icon: "warning",
          title: "Missing Information",
          html: alertHtml,
          showConfirmButton: false,
          showCloseButton: false,
          allowOutsideClick: false,
          allowEscapeKey: false,
        });
      }

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
        tax_percentage: response.data.tax_percentage || "0",
      });
    } catch (error) {
      console.error("Error fetching data", error);
    } finally {
      setLoading(false);
    }
  };

  const exportToPdf = () => {
    const element = invoiceRef.current;
    const opt = {
      margin: 0.5,
      filename: `invoice-${booking_id}.pdf`,
      image: { type: "jpeg", quality: 0.98 },
      html2canvas: {
        scale: 3,
        scrollY: 0,
        useCORS: true,
      },
      jsPDF: { unit: "in", format: "a4", orientation: "portrait" },
      pagebreak: { mode: ["avoid-all", "css", "legacy"] },
    };

    html2pdf().set(opt).from(element).save();
  };

  const printInvoice = () => {
    const printContents =
      document.querySelector(".printable-invoice").innerHTML;

    const printWindow = window.open("", "", "width=900,height=650");
    printWindow.document.write(`
    <html>
      <head>
        <title>Invoice Print</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            padding: 20px;
            margin: 0;
            color: #000;
          }
          .header {
            text-align: center;
            margin-bottom: 20px;
          }
          .header span {
            display: block;
            font-size: 18px;
            margin-bottom: 4px;
          }
          table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
          }
          table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
          }
          thead {
            background-color: #f8f8f8;
            font-weight: bold;
          }
          tfoot {
            background-color: #f1f1f1;
            font-weight: bold;
          }
          .table-success td {
            background-color: #d4edda !important;
            font-weight: bold;
          }
          .text-end {
            text-align: right;
          }
        </style>
      </head>
      <body onload="window.print(); setTimeout(() => window.close(), 100);">
        ${printContents}
      </body>
    </html>
  `);
    printWindow.document.close();
  };
  const taxAmount = (finalDiscountAmt * booking.tax_percentage) / 100;
  const totalWithTax = taxAmount;

  const grandTotal =
    parseFloat(finalDiscountAmt) +
    parseFloat(taxAmount) +
    parseFloat(itemGrandTotal);
  const convGrandTotal = grandTotal.toLocaleString("en-US", {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });

  const perDay = parseFloat(booking?.perday_roomprice) || 0;
  const days = parseFloat(booking?.total_booking_days) || 0;
  const tbill = perDay * days;

  // Split into integer and decimal parts
  const [integerPart, decimalPart] = grandTotal.toFixed(2).split(".");

  //const numberInWords = `${toWords(parseInt(integerPart))} Taka and ${toWords(parseInt(decimalPart))} Paisa`;
  const integerWords = capitalizeFirstLetter(toWords(parseInt(integerPart)));
  const decimalWords = capitalizeFirstLetter(toWords(parseInt(decimalPart)));
  const numberInWords = `${integerWords} Taka and ${decimalWords} Paisa`;

  function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }
  useEffect(() => {
    setFinalDiscountAmt(dueAmt - 0);
  }, [dueAmt]); // run whenever dueAmt changes

  useEffect(() => {
    const dAmount =
      parseFloat(tbill || 0) - parseFloat(booking.advance_amount || 0);
    setDueAmount(dAmount);
  }, [tbill, booking.advance_amount]);

  // Format for display
  const due_amount = dueAmt.toLocaleString("en-US", {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
  // Format as currency (example in USD)
  const total_bill = tbill.toLocaleString("en-US", {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });

  const formatDate = (dateStr) => {
    if (!dateStr) return "";
    return new Date(dateStr).toISOString().split("T")[0]; // "2024-09-01"
  };

  const formatCurrency = (amount) => {
    return Number(amount).toLocaleString("en-US", {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    });
  };

  const defaultFetchItems = async () => {
    try {
      const response = await axios.get(`/setting/activeItemList`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      //const userData = response.data;
      if (response.data) {
        setItemData(response.data);
      }
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };
  // Find selected item object
  const selectedItems = itemData.find(
    (item) => item.id === Number(selectedItemId)
  );
  // When item changes, set qty and price from selected item
  React.useEffect(() => {
    if (selectedItems) {
      setQty(selectedItems.quantity);
      setPrice(selectedItems.unit_price);
    } else {
      setQty("");
      setPrice("");
    }
  }, [selectedItems]);
  useEffect(() => {
    const sum = addedItems.reduce(
      (acc, item) => acc + parseFloat(item.total) || 0,
      0
    );
    setGrandTotal(sum.toFixed(2));
  }, [addedItems]);

  const fetchGlobalData = async () => {
    try {
      const response = await axios.get(`/public/getGlobalData`);
      setName(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    }
  };

  useEffect(() => {
    fetchGlobalData();
    fetechData();
    defaultFetchItems();
  }, []);

  return (
    <>
      <Helmet>
        <title>Print Invoice</title>
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
                <div className="breadcrumb-title pe-3">Invoice</div>
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
                        <Link to="/booking/checkout-list">
                          Back [ Booking ID: {booking.booking_id}]
                        </Link>
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

                    <div className="card shadow border-0 print-area p-4">
                      <div className="card-body">
                        {/* Invoice Section */}
                        <div ref={invoiceRef} className="printable-invoice">
                          <div className="header">
                            <span style={{ fontSize: "25px" }}>
                              {settingData.name}
                            </span>
                            <span>
                              Email: {settingData.email}, Phone:{" "}
                              {settingData.whatsApp}
                            </span>
                            <span>Facebook: {settingData.fblink}</span>
                            <span>Pechardwip, Cox's Bazar, Bangladesh</span>
                          </div>

                          {/* Items Table */}
                          {addedItems.length > 0 && (
                            <table>
                              <thead>
                                <tr>
                                  <th>#</th>
                                  <th>Item</th>
                                  <th>Qty</th>
                                  <th>Price</th>
                                  <th>Total</th>
                                </tr>
                              </thead>
                              <tbody>
                                {addedItems.map((item, index) => (
                                  <tr key={index}>
                                    <td>{index + 1}</td>
                                    <td>{item.name}</td>
                                    <td>{item.qty}</td>
                                    <td>{item.price}</td>
                                    <td>{item.total}</td>
                                  </tr>
                                ))}
                              </tbody>
                            </table>
                          )}

                          {/* Booking Summary Table */}
                          <table>
                            <thead>
                              <tr>
                                <th>#</th>
                                <th>Room Name</th>
                                <th>Check-In</th>
                                <th>Check-Out</th>
                                <th>Days</th>
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
                                <td>{booking.total_booking_days}</td>
                                <td>{booking.perday_roomprice}</td>
                                <td>
                                  {booking.perday_roomprice} x{" "}
                                  {booking.total_booking_days} ={" "}
                                  {formatCurrency(
                                    booking.perday_roomprice *
                                      booking.total_booking_days
                                  )}{" "}
                                  TK
                                </td>
                              </tr>
                            </tbody>
                            <tfoot>
                              <tr>
                                <td colSpan="6" className="text-end">
                                  Amount
                                </td>
                                <td className="text-end">{total_bill}</td>
                              </tr>
                              <tr>
                                <td colSpan="6" className="text-end">
                                  Advance Amount
                                </td>
                                <td className="text-end">
                                  {booking.advance_amount || 0}
                                </td>
                              </tr>
                              <tr>
                                <td colSpan="6" className="text-end">
                                  Due Amount
                                </td>
                                <td className="text-end">{due_amount || 0}</td>
                              </tr>
                              <tr>
                                <td colSpan="6" className="text-end">
                                  Discount
                                </td>
                                <td className="text-end">
                                  {discount_amt || 0}
                                </td>
                              </tr>
                              <tr>
                                <td colSpan="6" className="text-end">
                                  Total Amount
                                </td>
                                <td className="text-end">
                                  {formatCurrency(finalDiscountAmt || 0)}
                                </td>
                              </tr>
                              <tr>
                                <td colSpan="6" className="text-end">
                                  Tax ({booking.tax_percentage}%)
                                </td>
                                <td className="text-end">
                                  {formatCurrency(totalWithTax)}
                                </td>
                              </tr>
                              <tr>
                                <td colSpan="6" className="text-end">
                                  Item Total (+)
                                </td>
                                <td className="text-end">{itemGrandTotal}</td>
                              </tr>
                              <tr className="table-success">
                                <td colSpan="6" className="text-end">
                                  Grand Total
                                </td>
                                <td className="text-end">{convGrandTotal}</td>
                              </tr>
                            </tfoot>
                          </table>
                          <h3 className="txtowrd">{numberInWords}</h3>
                          <center>
                            {(bookingstatus === 1 ||
                              bookingstatus === 4) && (
                              <h2 style={{ color: "red" }}>
                                This invoice is not final. Please update the
                                status to complete it.
                              </h2>
                            )}
                          </center>
                        </div>

                        {/* Action Buttons */}
                        <div className="text-end mt-4">
                          <button
                            className="btn btn-outline-primary me-2"
                            onClick={exportToPdf}
                          >
                            Export PDF
                          </button>

                          <button
                            className="btn btn-outline-primary me-2"
                            onClick={printInvoice}
                          >
                            Print
                          </button>

                          {/* <button className="btn btn-primary" onClick={handleSubmit}>Submit</button> */}
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

export default PrintCheckOutInvoice;
