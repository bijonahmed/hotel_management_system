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

const Print = () => {
  const [searchParams] = useSearchParams();
  const invoice_id = searchParams.get("invoice_id");
  const navigate = useNavigate();
  const [errors, setErrors] = useState({});
  const { getToken, token, logout, http, setToken } = AuthUser();
  const [loading, setLoading] = useState(false);
  const [itemData, setItemData] = useState([]);
  const [itemGrandTotal, setGrandTotal] = useState(0);
  const [dueAmt, setDueAmount] = useState(0);
  const [totalAmt, setTotalAmut] = useState(0);
  const [convGrandTotal, setGTotal] = useState(0);
  const [advanceAmt, setAdvanceAmt] = useState("");
  const [addedItems, setAddedItems] = useState([]);
  const [discount_amt, setdiscountAmt] = useState(0);
  const [taxAmt, setTaxAmt] = useState(0);
  const [taxPercentage, setTaxPercent] = useState(0);
  const [invoiceno, setInvoiceno] = useState(0);

  const [settingData, setName] = useState({});
  const [currency_symbol, set_currency_symbol] = useState("");
  const invoiceRef = useRef();

  const [InsertData, setData] = useState({
    name: "",
    email: "",
    phone: "",
    address: "",
    tax_percentage: "",
  });

  const formatCurrency = (amount) => {
    return Number(amount).toLocaleString("en-US", {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    });
  };

  const amount = Number(convGrandTotal); // Ensures it's a number

const [integerPart, decimalPart] = amount.toFixed(2).split(".");
const integerWords = capitalizeFirstLetter(toWords(parseInt(integerPart)));
const decimalWords = capitalizeFirstLetter(toWords(parseInt(decimalPart)));
const numberInWords = `${integerWords} Taka and ${decimalWords} Paisa`;

  
  function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }

  const globalSetting = async () => {
    try {
      const response = await axios.get(`/setting/settingrowSystem`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      const userData = response.data.data;
      set_currency_symbol(userData.currency_symbol || "");
      const taxData = userData.tax_percentag;
      // setTaxPercetage(taxData);
      // set_currency_symbol(userData.currency_symbol || "");
      setData((prev) => ({
        ...prev,
        tax_percentage: taxData || 0,
      }));
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };

  const fetechData = async () => {
    setLoading(true);
    try {
      const response = await axios.get("/purchase/checkInvoiceRow", {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
        params: {
          id: invoice_id, // replace this with your actual variable or value
        },
      });

      const particularData = response.data.particularData;
      const ilistData = response.data.itemlist;
      setData({
        name: particularData.name || null,
        email: particularData.email || null,
        phone: particularData.phone || null,
        address: particularData.address || null,
        tax_percentage: particularData.tax_percentage || null,
      });

      setInvoiceno(particularData.invoice_no);
      setGrandTotal(particularData.item_total);
      setAdvanceAmt(particularData.advance_amount);
      setDueAmount(particularData.due_amount);
      setdiscountAmt(particularData.discount_amount);
      setTotalAmut(particularData.after_discount);
      setTaxPercent(particularData.tax_percentage);
      setTaxAmt(particularData.tax_amount);
      setGTotal(particularData.grand_total);
      setAddedItems(ilistData);
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
      filename: `invoice-${invoice_id}.pdf`,
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
            margin-bottom: 15px;
          }
          .header span {
            display: block;
            font-size: 12px;
            margin-bottom: 4px;
          }
          table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
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

  const fetchGlobalData = async () => {
    try {
      const response = await axios.get(`/public/getGlobalData`);
      setName(response.data);
    } catch (error) {
      console.error("Error fetching data", error);
    }
  };

  useEffect(() => {
    globalSetting();
    fetchGlobalData();
    fetechData();
    defaultFetchItems();
  }, []);

  return (
    <>
      <Helmet>
        <title>Purchase Print Invoice</title>
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
                <div className="breadcrumb-title pe-3">Purchase Invoice</div>
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
                        <Link to="/purchase/purchase-list">Back</Link>
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
                            <center>Purchase Invoice</center>
                            <span style={{ fontSize: "25px" }}>
                              {settingData.name}
                            </span>
                            <span>
                              Email: {settingData.email}, Phone:{" "}
                              {settingData.whatsApp}
                            </span>
                            <span>Facebook: {settingData.fblink}</span>
                            <span>{settingData.address}</span>
                          </div>
                          <hr />
                          <center><b>Invoice No: {invoiceno}</b></center>

                          <div
                            style={{
                              padding: "1rem",
                              border: "1px solid #ccc",
                              borderRadius: "8px",
                              maxWidth: "500px",
                            }}
                          >
                            <div style={{ marginBottom: "0.5rem" }}>
                              <strong>Name:</strong> {InsertData.name || "N/A"}
                            </div>

                            <div style={{ marginBottom: "0.5rem" }}>
                              <strong>Phone:</strong>{" "}
                              {InsertData.phone || "N/A"}
                            </div>

                            <div style={{ marginBottom: "0.5rem" }}>
                              <strong>Email:</strong>{" "}
                              {InsertData.email || "N/A"}
                            </div>

                            <div style={{ marginBottom: "0.5rem" }}>
                              <strong>Address:</strong>{" "}
                              {InsertData.address || "N/A"}
                            </div>
                          </div>
                          <br />

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
                                    <td className="text-start">{item.name}</td>
                                    <td>{item.qty}</td>
                                    <td>{item.price}</td>
                                    <td>{item.total}</td>
                                  </tr>
                                ))}
                              </tbody>
                            </table>
                          )}

                          <table className="table table-bordered">
                            <tfoot>
                              <tr>
                                <th colSpan={6} className="text-end">
                                  Amount
                                </th>
                                <td className="text-start">
                                  {itemGrandTotal} {currency_symbol}
                                </td>
                              </tr>
                              <tr>
                                <th colSpan={6} className="text-end">
                                  Advance Amount
                                </th>
                                <td className="text-start">
                                  {advanceAmt} {currency_symbol}
                                </td>
                              </tr>
                              <tr>
                                <th colSpan={6} className="text-end">
                                  Due Amount
                                </th>
                                <td className="text-start">
                                  {dueAmt} {currency_symbol}
                                </td>
                              </tr>

                              <tr>
                                <th colSpan={6} className="text-end">
                                  Discount
                                </th>
                                <td className="text-start">
                                  {discount_amt} {currency_symbol}
                                </td>
                              </tr>

                              <tr>
                                <th colSpan={6} className="text-end">
                                  Total Amount
                                </th>
                                <td className="text-start">
                                  {formatCurrency(totalAmt)} {currency_symbol}
                                </td>
                              </tr>

                              <tr>
                                <th colSpan={6} className="text-end">
                                  Tax ({taxPercentage})%
                                </th>
                                <td className="text-start">
                                  {formatCurrency(taxAmt)}

                                  {currency_symbol}
                                </td>
                              </tr>

                              <tr>
                                <th colSpan={6} className="text-end">
                                  <strong>Grand Total</strong>
                                </th>
                                <td className="text-start">
                                  {convGrandTotal}
                                  {currency_symbol}
                                </td>
                              </tr>
                            </tfoot>
                          </table>
                          <h3 className="txtowrd">{numberInWords}</h3>
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

export default Print;
