import React, { useState, useEffect } from "react";
import { Helmet } from "react-helmet";
import GuestNavbar from "../../components/Navbar";
import { Link, useNavigate } from "react-router-dom";
import Footer from "../../components/Footer";
import LeftSideBarComponent from "../../components/LeftSideBarComponent";
import axios from "/config/axiosConfig";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import AuthUser from "../../components/AuthUser";

const CreateInvoice = () => {
  const navigate = useNavigate();
  const { token } = AuthUser();
  const MySwal = withReactContent(Swal);

  // Form & item states
  const [InsertData, setData] = useState({
    name: "",
    email: "",
    phone: "",
    address: "",
    tax_percentage: 0,
  });

  const [itemName, setItemName] = useState("");
  const [qty, setQty] = useState("");
  const [price, setPrice] = useState("");
  const [total, setTotal] = useState("");
  const [addedItems, setAddedItems] = useState([]);

  // Calculation states
  const [itemGrandTotal, setItemGrandTotal] = useState(0);
  const [advanceAmt, setAdvanceAmt] = useState("");
  const [dueAmt, setDueAmount] = useState(0);
  const [discount_amt, setdiscountAmt] = useState("");
  const [finalDiscountAmt, setFinalDiscountAmt] = useState(0);
  const [totalWithTax, setTotalWithTax] = useState(0);
  const [convGrandTotal, setConvGrandTotal] = useState(0);
  const [currency_symbol, set_currency_symbol] = useState("");

  const [showModal, setShowModal] = useState(false);
  const handleCloseModal = () => setShowModal(false);

  // Currency formatting
  const formatCurrency = (val) => {
    const num = parseFloat(val);
    return isNaN(num)
      ? "0.00"
      : num.toLocaleString("en-US", {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2,
        });
  };

  // Calculate live item total
  useEffect(() => {
    const q = parseFloat(qty);
    const p = parseFloat(price);
    if (!isNaN(q) && !isNaN(p)) {
      setTotal((q * p).toFixed(2));
    } else {
      setTotal("");
    }
  }, [qty, price]);

  // Load and save addedItems from localStorage
  useEffect(() => {
    const stored = localStorage.getItem("addedItems");
    if (stored) setAddedItems(JSON.parse(stored));
  }, []);

  useEffect(() => {
    localStorage.setItem("addedItems", JSON.stringify(addedItems));
  }, [addedItems]);

  // Fetch global settings
  useEffect(() => {
    async function fetchSettings() {
      try {
        const res = await axios.get(`/setting/settingrowSystem`, {
          headers: { Authorization: `Bearer ${token}` },
        });
        const userData = res.data.data;
        set_currency_symbol(userData.currency_symbol || "$");
        setData((prev) => ({
          ...prev,
          tax_percentage: parseFloat(userData.tax_percentage || 0),
        }));
      } catch (err) {
        console.error("Settings error:", err);
      }
    }
    fetchSettings();
  }, [token]);

  // All Calculations
  useEffect(() => {
    const total = addedItems.reduce((sum, item) => sum + Number(item.total), 0);
    setItemGrandTotal(total);

    const discount = parseFloat(discount_amt) || 0;
    const afterDiscount = Math.max(total - discount, 0);
    setFinalDiscountAmt(afterDiscount);

    const tax = parseFloat(InsertData.tax_percentage) || 0;
    const taxAmount = (afterDiscount * tax) / 100;
    const grandTotal = afterDiscount + taxAmount;

    setTotalWithTax(grandTotal);
    setConvGrandTotal(grandTotal);

    const advance = parseFloat(advanceAmt) || 0;
    const due = Math.max(afterDiscount - advance, 0);
    setDueAmount(due);
  }, [addedItems, discount_amt, advanceAmt, InsertData.tax_percentage]);

  // Add or update item
  const handleAdd = () => {
    if (!itemName.trim() || !qty || !price) {
      MySwal.fire("Error", "Please fill Item Name, Qty, and Price", "error");
      return;
    }

    if (isNaN(qty) || isNaN(price)) {
      MySwal.fire("Error", "Qty and Price must be valid numbers", "error");
      return;
    }

    setAddedItems((prev) => {
      const index = prev.findIndex(
        (item) => item.name.toLowerCase() === itemName.trim().toLowerCase()
      );

      const itemPayload = {
        name: itemName.trim(),
        qty: Number(qty),
        price: Number(price),
        total: Number((qty * price).toFixed(2)),
      };

      if (index !== -1) {
        const updated = [...prev];
        const exist = updated[index];
        const newQty = exist.qty + itemPayload.qty;
        const newTotal = newQty * itemPayload.price;

        updated[index] = {
          ...exist,
          qty: newQty,
          price: itemPayload.price,
          total: Number(newTotal.toFixed(2)),
        };
        return updated;
      }

      return [...prev, itemPayload];
    });

    setItemName("");
    setQty("");
    setPrice("");
    setTotal("");
  };

  // Remove item
  const handleRemove = (index) => {
    Swal.fire({
      title: "Are you sure?",
      text: "Do you want to remove this item?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#d33",
      cancelButtonColor: "#3085d6",
      confirmButtonText: "Yes, remove it!",
    }).then((result) => {
      if (result.isConfirmed) {
        const newList = [...addedItems];
        newList.splice(index, 1);
        setAddedItems(newList);
        Swal.fire("Removed!", "Item has been removed.", "success");
      }
    });
  };

  // Handle inputs
  const handleAdvanceCalculate = (e) => {
    const val = e.target.value;
    if (val === "" || /^\d*\.?\d*$/.test(val)) setAdvanceAmt(val);
  };

  const handleChangeDiscount = (e) => {
    const val = e.target.value;
    if (val === "" || /^\d*\.?\d*$/.test(val)) setdiscountAmt(val);
  };

  const handleSubmitModal = () => setShowModal(true);

  const handleConfirm = async () => {
    const data = {
      name: InsertData.name,
      email: InsertData.email,
      phone: InsertData.phone,
      address: InsertData.address,
      item_total: itemGrandTotal,
      advance_amount: parseFloat(advanceAmt) || 0,
      due_amount: dueAmt,
      discount_amount: parseFloat(discount_amt) || 0,
      after_discount: finalDiscountAmt,
      tax_percentage: InsertData.tax_percentage,
      tax_amount: totalWithTax - finalDiscountAmt,
      grand_total: convGrandTotal,
      items: addedItems,
    };

    try {
      const res = await axios.post("/purchase/insertItems", data, {
        headers: { Authorization: `Bearer ${token}` },
      });

      // ✅ Clear cart from localStorage and state
      localStorage.removeItem("addedItems");
      setAddedItems([]); // clear from state as well

      Swal.fire({
        icon: "success",
        title: "Successfully created invoice.",
        timer: 3000,
        toast: true,
        position: "top-end",
        showConfirmButton: false,
      });

      navigate(`/restaurant/print-invoice?invoice_id=${res.data.invoiceid}`);
    } catch (err) {
      if (err.response?.status === 422) {
        Swal.fire({
          icon: "error",
          title: "Validation Errors",
          html: Object.values(err.response.data.errors)
            .map((errs) => errs.join("<br>"))
            .join(""),
        });
      } else {
        Swal.fire("Error", err.message || "Unexpected error", "error");
      }
    } finally {
      setShowModal(false);
    }
  };

  return (
    <>
      <Helmet>
        <title>Create Invoice</title>
      </Helmet>

      <div className="wrapper">
        <LeftSideBarComponent />
        <header>
          <GuestNavbar />
        </header>

        <div className="page-wrapper">
          <div className="page-content">
            <div className="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
              <div className="breadcrumb-title pe-3">
                Create Purchase Invoice
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
                      <Link to="/purchase/purchase-list">Back</Link>
                    </li>
                  </ol>
                </nav>
              </div>
            </div>

            <div className="container-fluid">
              <div className="card">
                <div className="card-header">
                  <ul
                    className="nav nav-tabs card-header-tabs"
                    id="InsertDataTabs"
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
                  </ul>
                </div>

                <div className="card-body">
                  <div className="tab-content" id="InsertDataTabsContent">
                    <div
                      className="tab-pane fade show active"
                      id="invoice"
                      role="tabpanel"
                      aria-labelledby="invoice-tab"
                    >
                      {/* Customer Info */}
                      <div className="row g-3 mb-4">
                        <div className="col-md-6">
                          <label className="form-label text-muted">
                            Mobile No.
                          </label>
                          <input
                            type="text"
                            className="form-control"
                            placeholder="Mobile No."
                            value={InsertData.phone}
                            onChange={(e) =>
                              setData({ ...InsertData, phone: e.target.value })
                            }
                          />
                        </div>
                        <div className="col-md-6">
                          <label className="form-label text-muted">Name</label>
                          <input
                            type="text"
                            className="form-control"
                            placeholder="Name"
                            value={InsertData.name}
                            onChange={(e) =>
                              setData({ ...InsertData, name: e.target.value })
                            }
                          />
                        </div>
                        <div className="col-md-6">
                          <label className="form-label text-muted">Email</label>
                          <input
                            type="text"
                            className="form-control"
                            placeholder="Email"
                            value={InsertData.email}
                            onChange={(e) =>
                              setData({ ...InsertData, email: e.target.value })
                            }
                          />
                        </div>
                        <div className="col-md-6">
                          <label className="form-label text-muted">
                            Address
                          </label>
                          <input
                            type="text"
                            className="form-control"
                            placeholder="Address"
                            value={InsertData.address}
                            onChange={(e) =>
                              setData({
                                ...InsertData,
                                address: e.target.value,
                              })
                            }
                          />
                        </div>
                      </div>

                      {/* Add item row */}
                      <table className="table table-bordered mb-4">
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
                              <input
                                type="text"
                                className="form-control"
                                placeholder="Item Name"
                                value={itemName}
                                onChange={(e) => setItemName(e.target.value)}
                              />
                            </td>
                            <td>
                              <input
                                type="text"
                                className="form-control"
                                placeholder="Qty"
                                value={qty}
                                onChange={(e) => setQty(e.target.value)}
                              />
                            </td>
                            <td>
                              <input
                                type="text"
                                className="form-control"
                                placeholder="Price"
                                value={price}
                                onChange={(e) => setPrice(e.target.value)}
                              />
                            </td>
                            <td>
                              <input
                                type="text"
                                className="form-control"
                                placeholder="Total"
                                value={total}
                                disabled
                              />
                            </td>
                            <td>
                              <button
                                className="btn btn-lg btn-primary"
                                onClick={handleAdd}
                              >
                                Add
                              </button>
                            </td>
                          </tr>
                        </tbody>
                      </table>

                      {/* Added items */}
                      {addedItems.length > 0 && (
                        <div className="mb-4">
                          <h5>Added Items</h5>
                          <table className="table table-bordered">
                            <thead>
                              <tr>
                                <th>#</th>
                                <th>Item</th>
                                <th>Qty</th>
                                <th>Price</th>
                                <th>Total</th>
                                <th>Remove</th>
                              </tr>
                            </thead>
                            <tbody>
                              {addedItems.map((item, index) => (
                                <tr key={index}>
                                  <td>{index + 1}</td>
                                  <td>{item.name}</td>
                                  <td>{item.qty}</td>
                                  <td>{formatCurrency(item.price)}</td>
                                  <td>{formatCurrency(item.total)}</td>
                                  <td>
                                    <button
                                      className="btn btn-sm btn-danger"
                                      onClick={() => handleRemove(index)}
                                    >
                                      Remove
                                    </button>
                                  </td>
                                </tr>
                              ))}
                            </tbody>
                            <tfoot>
                              <tr>
                                <th colSpan={4} className="text-end">
                                  Amount
                                </th>
                                <td>
                                  {formatCurrency(itemGrandTotal)}{" "}
                                  {currency_symbol}
                                </td>
                                <td></td>
                              </tr>
                              <tr>
                                <th colSpan={4} className="text-end">
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
                                <td></td>
                              </tr>
                              <tr>
                                <th colSpan={4} className="text-end">
                                  Paid Amount
                                </th>
                                <td>
                                  <input
                                    type="text"
                                    className="form-control"
                                    placeholder="0.00"
                                    value={advanceAmt}
                                    onChange={handleAdvanceCalculate}
                                  />
                                </td>
                                <td></td>
                              </tr>
                              <tr>
                                <th colSpan={4} className="text-end">
                                  Due Amount
                                </th>
                                <td>
                                  <input
                                    type="text"
                                    className="form-control"
                                    placeholder="0.00"
                                    value={formatCurrency(dueAmt)}
                                    disabled
                                    readOnly
                                  />
                                </td>
                                <td></td>
                              </tr>
                              <tr className="d-none">
                                <th colSpan={4} className="text-end">
                                  Tax ({InsertData.tax_percentage}%)
                                </th>
                                <td>
                                  {formatCurrency(
                                    totalWithTax - finalDiscountAmt
                                  )}
                                </td>
                                <td></td>
                              </tr>
                              <tr>
                                <th colSpan={4} className="text-end">
                                  <strong>Grand Total</strong>
                                </th>
                                <td>
                                  {formatCurrency(convGrandTotal)}{" "}
                                  {currency_symbol}
                                </td>
                                <td></td>
                              </tr>
                            </tfoot>
                          </table>
                        </div>
                      )}

                      <div className="d-flex justify-content-end">
                        <button
                          className="btn btn-primary"
                          onClick={handleSubmitModal}
                          disabled={addedItems.length === 0}
                        >
                          Submit Invoice
                        </button>
                      </div>

                      {/* Confirmation Modal */}
                      {showModal && (
                        <div
                          className="modal fade show"
                          tabIndex={-1}
                          style={{
                            display: "block",
                            backgroundColor: "rgba(0,0,0,0.5)",
                          }}
                        >
                          <div className="modal-dialog">
                            <div className="modal-content">
                              <div className="modal-header">
                                <h5 className="modal-title">
                                  Confirm Invoice Submission
                                </h5>
                                <button
                                  type="button"
                                  className="btn-close"
                                  onClick={handleCloseModal}
                                ></button>
                              </div>
                              <div className="modal-body">
                                <p>
                                  Are you sure you want to submit this invoice?
                                </p>
                              </div>
                              <div className="modal-footer">
                                <button
                                  className="btn btn-secondary"
                                  onClick={handleCloseModal}
                                >
                                  Cancel
                                </button>
                                <button
                                  className="btn btn-primary"
                                  onClick={handleConfirm}
                                >
                                  Yes, Submit
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <Footer />
      </div>
    </>
  );
};

export default CreateInvoice;
