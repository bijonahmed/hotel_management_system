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
import withReactContent from "sweetalert2-react-content";
import ReactDOMServer from "react-dom/server";

const CheckOutInvoice = () => {
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
  const [status, setStatus] = useState("");
  const [note, setNote] = useState("");
  const [finalDiscountAmt, setFinalDiscountAmt] = useState(0);
  const [showModal, setShowModal] = useState(false);
  const handleClose = () => setShowModal(false);

  const handleChangeDiscount = (e) => {
    const discountValue = parseFloat(e.target.value) || 0;
    setdiscountAmt(discountValue);
    const finalAmount = dueAmt - discountValue;
    setFinalDiscountAmt(finalAmount);
  };

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
      //console.log("API Response:", response.data.itemlist); // Log the response

      const bookingData = response.data.booking_data;
      setAddedItems(response.data.itemlist);
      setdiscountAmt(response.data.booking_data.discount_amount);

      setPreview({
        front: response.data.front || null,
        back: response.data.back || null,
      });
      // const bookingBackImg  = response.data.booking_back;

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

  const handleSubmitModal = () => {
    setShowModal(true);
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    if (name === "status") setStatus(value);
    if (name === "note") setNote(value);
  };

  const handleConfirm = async () => {
    // console.log("All items:" + addedItems);
    const data = {
      room_id: booking.room_id,
      booking_id: booking.booking_id,
      advance_amount: booking.advance_amount,
      total_bill: total_bill,
      due_amount: due_amount,
      discount_amount: discount_amt,
      final_total_amount: finalDiscountAmt,
      tax_amount: totalWithTax,
      item_total: itemGrandTotal,
      grand_total: convGrandTotal,
      status: status,
      note: note,
      items: addedItems, // attaching mapped item list
    };

    try {
      const response = await axios.post("/booking/bookingInvoiceInsert", data, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      console.log("Success:", response.data);
      //alert("Booking saved successfully!");
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
        title: "Successfully create invoice.",
      });

      navigate("/booking/checkout-list");
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
      //console.error("Error:", error);
      //alert("Failed to save booking!");
    }
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
  const total_bill = tbill.toLocaleString("en-US");
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
  // Calculate total
  const total = qty && price ? (qty * price).toFixed(2) : "";
  // Add item to list
  // Calculate grand total whenever addedItems changes
  useEffect(() => {
    const sum = addedItems.reduce(
      (acc, item) => acc + parseFloat(item.total) || 0,
      0
    );
    setGrandTotal(sum.toFixed(2));
  }, [addedItems]);

  function handleAdd() {
    if (!selectedItemId || !qty || !price) return;

    const selectedItem = itemData.find(
      (item) => item.id === Number(selectedItemId)
    );
    if (!selectedItem) return;

    setAddedItems((prev) => {
      const existingIndex = prev.findIndex(
        (item) => item.id === Number(selectedItemId)
      );

      if (existingIndex !== -1) {
        const updatedItems = [...prev];
        const existingItem = updatedItems[existingIndex];
        const newQty = existingItem.qty + Number(qty);
        updatedItems[existingIndex] = {
          ...existingItem,
          qty: newQty,
          total: Number((newQty * existingItem.price).toFixed(2)),
        };
        return updatedItems;
      } else {
        return [
          ...prev,
          {
            id: selectedItem.id,
            name: selectedItem.name,
            qty: Number(qty),
            price: Number(price),
            total: Number((qty * price).toFixed(2)),
          },
        ];
      }
    });

    setSelectedItemId("");
    setQty("");
    setPrice("");
    // setTotal("");
  }
  // Remove item by index
  async function handleRemove(index, id) {
    const result = await Swal.fire({
      title: "Are you sure?",
      text: "Do you really want to delete this item?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Yes, delete it!",
      cancelButtonText: "Cancel",
    });

    if (result.isConfirmed) {
      // Remove item from UI
      setAddedItems((prev) => prev.filter((_, i) => i !== index));

      try {
        const response = await axios.get("/booking/deleteBookingInvItem", {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
          params: {
            booking_id: booking_id,
            id: id,
          },
        });

        Swal.fire("Deleted!", "The item has been deleted.", "success");
        console.log("Check booking response:", response.data);
      } catch (error) {
        Swal.fire("Error", "There was a problem deleting the item.", "error");
        console.error("Error checking booking row:", error);
      }
    } else {
      Swal.fire("Cancelled", "Your item is safe.", "info");
    }
  }

  useEffect(() => {
    fetechData();
    defaultFetchItems();
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
                                      <th>Item</th>
                                      <th>Qty</th>
                                      <th>Price</th>
                                      <th>Total</th>
                                      <th>Add</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    <tr>
                                      <td>--</td>
                                      <td>
                                        <select
                                          className="form-control"
                                          value={selectedItemId}
                                          onChange={(e) =>
                                            setSelectedItemId(e.target.value)
                                          }
                                        >
                                          <option value="">Select item</option>
                                          {itemData.map((item) => (
                                            <option
                                              key={item.id}
                                              value={item.id}
                                            >
                                              {item.name}
                                            </option>
                                          ))}
                                        </select>
                                      </td>
                                      <td>
                                        <input
                                          type="number"
                                          className="form-control"
                                          placeholder="Qty"
                                          min="1"
                                          value={qty}
                                          onChange={(e) =>
                                            setQty(e.target.value)
                                          }
                                        />
                                      </td>
                                      <td>
                                        <input
                                          type="number"
                                          className="form-control"
                                          placeholder="Price"
                                          value={price}
                                          disabled
                                          readOnly
                                        />
                                      </td>
                                      <td>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="Total"
                                          value={total}
                                          disabled
                                          readOnly
                                        />
                                      </td>
                                      <td>
                                        <button
                                          className="btn btn-sm btn-success"
                                          onClick={handleAdd}
                                          disabled={
                                            !selectedItemId || !qty || qty <= 0
                                          }
                                        >
                                          Add
                                        </button>
                                      </td>
                                    </tr>
                                  </tbody>
                                </table>

                                {addedItems.length > 0 && (
                                  <>
                                    <table className="table table-bordered">
                                      <thead>
                                        <tr>
                                          <th>#</th>
                                          <th>Item</th>
                                          <th className="text-center">Qty</th>
                                          <th className="text-center">Price</th>
                                          <th className="text-center">Total</th>
                                          <th className="text-center">
                                            Remove
                                          </th>
                                        </tr>
                                      </thead>
                                      <tbody>
                                        {addedItems.map((item, index) => (
                                          <tr key={index}>
                                            <td>{index + 1}</td>
                                            <td>{item.name}</td>
                                            <td className="text-center">
                                              {item.qty}
                                            </td>
                                            <td className="text-center">
                                              {item.price}
                                            </td>
                                            <td className="text-center">
                                              {item.total}
                                            </td>
                                            <td className="text-center">
                                              <button
                                                className="btn btn-sm btn-danger"
                                                onClick={() =>
                                                  handleRemove(index, item.id)
                                                }
                                              >
                                                Remove
                                              </button>
                                            </td>
                                          </tr>
                                        ))}
                                      </tbody>
                                    </table>
                                  </>
                                )}

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
                                        {booking.perday_roomprice} x{" "}
                                        {booking.total_booking_days} ={" "}
                                        {formatCurrency(
                                          booking.perday_roomprice *
                                            booking.total_booking_days
                                        )}
                                        TK
                                      </td>
                                    </tr>
                                  </tbody>
                                  <tfoot>
                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Amount
                                      </th>
                                      <td>
                                        {total_bill}
                                        {" TK"}
                                      </td>
                                    </tr>
                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Advance Amount
                                      </th>
                                      <td>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="0.00"
                                          value={booking.advance_amount || 0}
                                          onChange={(e) =>
                                            setBooking({
                                              ...booking,
                                              advance_amount: e.target.value,
                                            })
                                          }
                                        />
                                      </td>
                                    </tr>
                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Due Amount
                                      </th>
                                      <td>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="0.00"
                                          value={due_amount}
                                          disabled
                                          readOnly
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
                                          value={discount_amt}
                                          onChange={handleChangeDiscount}
                                        />
                                      </td>
                                    </tr>

                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Total Amount
                                      </th>
                                      <td>
                                        {formatCurrency(finalDiscountAmt || 0)}{" "}
                                        {" TK"}
                                      </td>
                                    </tr>

                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Tax ({booking.tax_percentage})%
                                      </th>
                                      <td>{formatCurrency(totalWithTax)}</td>
                                    </tr>

                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Item Total (+)
                                      </th>
                                      <td>
                                        {itemGrandTotal} {" TK"}
                                      </td>
                                    </tr>
                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        <strong>Grand Total</strong>
                                      </th>
                                      <td>
                                        {convGrandTotal} {" TK"}
                                      </td>
                                    </tr>
                                  </tfoot>
                                </table>
                                <div className="text-end mt-3">
                                  <button
                                    className="btn btn-primary"
                                    onClick={handleSubmitModal}
                                  >
                                    Submit
                                  </button>

                                  {/* <button className="btn btn-primary" onClick={handleSubmit}>
                                  Submit
                                </button> */}
                                </div>
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

          {/* Modal */}
          {showModal && (
            <div className="modal show d-block" tabIndex="-1" role="dialog">
              <div className="modal-dialog" role="document">
                <div className="modal-content">
                  <div className="modal-header">
                    <h5 className="modal-title">Confirm Submission</h5>
                    <button
                      type="button"
                      className="btn-close"
                      onClick={handleClose}
                    ></button>
                  </div>
                  <div className="modal-body">
                    <select
                      className="form-select w-100"
                      value={status}
                      onChange={handleChange}
                      name="status"
                      style={{ width: "200px", marginBottom: "10px" }}
                    >
                      <option value="">Select Status</option>
                      <option value="2">Release</option>
                      <option value="3">Cancel</option>
                      <option value="4">Others</option>
                    </select>

                    <textarea
                      className="form-control w-100"
                      name="note"
                      value={note}
                      onChange={handleChange}
                      placeholder="IF need write your special message here..."
                      rows="4"
                      style={{ width: "400px", marginTop: "10px" }}
                    ></textarea>
                  </div>
                  <div className="modal-footer">
                    <button
                      type="button"
                      className="btn btn-secondary"
                      onClick={handleClose}
                    >
                      Cancel
                    </button>
                    <button
                      type="button"
                      className="btn btn-primary"
                      onClick={handleConfirm}
                    >
                      Confirm
                    </button>
                  </div>
                </div>
              </div>
            </div>
          )}

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
