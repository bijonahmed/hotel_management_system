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
import Select from "react-select";

const CreateInvoice = () => {
  const navigate = useNavigate();
  const [errors, setErrors] = useState({});
  const { getToken, token, logout, http, setToken } = AuthUser();
  const [loading, setLoading] = useState(false);
  const [searchParams] = useSearchParams();
  const [itemData, setItemData] = useState([]);
  const [selectedItemId, setSelectedItemId] = useState("");
  const [qty, setQty] = useState("");
  const [price, setPrice] = useState(0);
  const [itemGrandTotal, setGrandTotal] = useState(0);
  const [dueAmt, setDueAmount] = useState(0);
  const [advanceAmt, setAdvanceAmt] = useState("");
  const [addedItems, setAddedItems] = useState([]);
  const MySwal = withReactContent(Swal);
  const [discount_amt, setdiscountAmt] = useState(0);
  const [taxPercetage, setTaxPercetage] = useState(0);
  const [status, setStatus] = useState("");
  const [note, setNote] = useState("");
  const [finalDiscountAmt, setFinalDiscountAmt] = useState(0);
  const [showModal, setShowModal] = useState(false);
  const handleClose = () => setShowModal(false);

  const [currency_symbol, set_currency_symbol] = useState("");

  const globalSetting = async () => {
    try {
      const response = await axios.get(`/setting/settingrowSystem`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      const userData = response.data.data;
      set_currency_symbol(userData.currency_symbol || "");
      const taxData = userData.tax_percentag;
      setTaxPercetage(taxData);
      // set_currency_symbol(userData.currency_symbol || "");
      setData((prev) => ({
        ...prev,
        tax_percentage: taxData || 0,
      }));
    } catch (error) {
      console.error("Error fetching user data:", error);
    }
  };

  const handleChangeDiscount = (e) => {
    const discountValue = parseFloat(e.target.value) || 0;
    setdiscountAmt(discountValue);
    const finalAmount = dueAmt - discountValue;
    setFinalDiscountAmt(finalAmount);
  };

  const handleAdvanceCalculate = (e) => {
    const iTotal = itemGrandTotal || 0;
    const advAmt = parseFloat(e.target.value) || 0;
    const getAmt = parseFloat(iTotal) - parseFloat(advAmt);
    setAdvanceAmt(advAmt);
    setDueAmount(getAmt);
  };

  const [InsertData, setData] = useState({
    name: "",
    email: "",
    phone: "",
    address: "",
    tax_percentage: "",
  });

  const handleSubmitModal = () => {
    setShowModal(true);
  };

  const handleConfirm = async () => {
    // console.log("All items:" + addedItems);
    const data = {
      name: InsertData.name,
      email: InsertData.email,
      phone: InsertData.phone,
      address: InsertData.address,
      item_total: itemGrandTotal,
      advance_amount: advanceAmt,
      due_amount: due_amount,
      discount_amount: discount_amt,
      after_discount: finalDiscountAmt,
      tax_percentage: taxPercetage,
      tax_amount: totalWithTax,
      grand_total: convGrandTotal,
      status: status,
      note: note,
      items: addedItems, // attaching mapped item list
    };

    try {
      const response = await axios.post("/restaurant/insertItems", data, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      //console.log("Success:", response.data.invoiceid);
      const invoiceid = response.data.invoiceid; 
    //  alert(invoiceid);
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
      navigate(`/restaurant/print-invoice?invoice_id=${invoiceid}`);
      //navigate("/InsertData/checkout-list");
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
          title: "InsertData Conflict",
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
      //alert("Failed to save InsertData!");
    }
  };
  const taxAmount = (finalDiscountAmt * InsertData.tax_percentage) / 100;
  const totalWithTax = taxAmount;

  const grandTotal = parseFloat(finalDiscountAmt) + parseFloat(taxAmount);
  const convGrandTotal = grandTotal.toLocaleString("en-US", {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });

  const perDay = parseFloat(InsertData?.perday_roomprice) || 0;
  const days = parseFloat(InsertData?.total_InsertData_days) || 0;
  const tbill = perDay * days;

  useEffect(() => {
    setFinalDiscountAmt(dueAmt - 0);
  }, [dueAmt]); // run whenever dueAmt changes

  useEffect(() => {
    const dAmount =
      parseFloat(tbill || 0) - parseFloat(InsertData.advance_amount || 0);
    setDueAmount(dAmount);
  }, [tbill, InsertData.advance_amount]);

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

  const options = itemData.map((item) => ({
    value: item.id,
    label: item.name,
  }));

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
        (item) => item.item_id === Number(selectedItemId)
      );

      const itemPayload = {
        item_id: selectedItem.id,
        name: selectedItem.name,
        qty: Number(qty),
        price: Number(price),
        total: Number((qty * price).toFixed(2)),
      };

      if (existingIndex !== -1) {
        // If item exists, update its quantity and total using new price
        const updatedList = [...prev];
        const existingItem = updatedList[existingIndex];

        const newQty = existingItem.qty + Number(qty);
        const newPrice = Number(price); // Use the latest input price
        const newTotal = Number((newQty * newPrice).toFixed(2));

        updatedList[existingIndex] = {
          ...existingItem,
          qty: newQty,
          price: newPrice, // Update price to new value
          total: newTotal,
        };

        return updatedList;
      } else {
        // If new item, just add it
        return [...prev, itemPayload];
      }
    });

    // Clear inputs after adding
    setSelectedItemId("");
    setQty("");
    setPrice("");
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

      const updatedItems = addedItems.filter((_, i) => i !== index);
      setAddedItems(updatedItems); // update the UI list

      const newItemTotal = updatedItems.reduce((sum, item) => {
        const itemPrice = parseFloat(item.price || 0);
        const itemQty = parseFloat(item.qty || 1); // default to 1 if qty is missing
        return sum + itemPrice * itemQty;
      }, 0);

      console.log("Updated Item Grand Total: " + newItemTotal);
      const dueAmt = newItemTotal - parseFloat(advanceAmt || 0);
      setDueAmount(dueAmt);
    } else {
      Swal.fire("Cancelled", "Your item is safe.", "info");
    }
  }

  useEffect(() => {
    globalSetting();
    defaultFetchItems();
  }, []);

  return (
    <>
      <Helmet>
        <title>Create Invoice</title>
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
                <div className="breadcrumb-title pe-3">Create Invoice</div>
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
                        <Link to="/restaurant/restaurant-invoice">Back</Link>
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
                          {/* Invoice Tab */}
                          <div
                            className="tab-pane fade show active"
                            id="invoice"
                            role="tabpanel"
                            aria-labelledby="invoice-tab"
                          >
                            {/* INSERT INVOICE CONTENT HERE */}

                            <div className="card mb-3">
                              <div className="card-body">
                                <div className="row g-3">
                                  <div className="col-md-12 col-lg-12 d-flex">
                                    <div className="card flex-fill w-100 border">
                                      <div className="card-body">
                                        <div className="row g-3">
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
                                                  value={InsertData.phone}
                                                  onChange={(e) =>
                                                    setData({
                                                      ...InsertData,
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
                                                Name
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-person-circle" />
                                                </span>
                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="Name"
                                                  value={InsertData.name}
                                                  onChange={(e) =>
                                                    setData({
                                                      ...InsertData,
                                                      name: e.target.value,
                                                    })
                                                  }
                                                />
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
                                                  <i className="bi bi-person-circle" />
                                                </span>
                                                <input
                                                  type="text"
                                                  className="form-control"
                                                  placeholder="Email"
                                                  value={InsertData.email}
                                                  onChange={(e) =>
                                                    setData({
                                                      ...InsertData,
                                                      email: e.target.value,
                                                    })
                                                  }
                                                />
                                              </div>
                                            </div>
                                          </div>

                                          <div className="col-md-6">
                                            <div className="form-group">
                                              <label className="form-label text-muted">
                                                Address
                                              </label>
                                              <div className="input-group">
                                                <span className="input-group-text">
                                                  <i className="bi bi-briefcase" />
                                                </span>

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
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>

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
                                        <Select
                                          className="basic-single"
                                          classNamePrefix="select"
                                          value={options.find(
                                            (option) =>
                                              option.value === selectedItemId
                                          )}
                                          onChange={(selectedOption) =>
                                            setSelectedItemId(
                                              selectedOption?.value || ""
                                            )
                                          }
                                          options={options}
                                          isClearable
                                          placeholder="Select item"
                                        />
                                      </td>
                                      <td>
                                        <input
                                          type="number"
                                          className="form-control"
                                          placeholder="Qty"
                                          min="1"
                                          value={qty ?? ""}
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
                                          value={price ?? ""}
                                          disabled
                                          readOnly
                                        />
                                      </td>
                                      <td>
                                        <input
                                          type="text"
                                          className="form-control"
                                          placeholder="Total"
                                          value={total ?? ""}
                                          disabled
                                          readOnly
                                        />
                                      </td>
                                      <td>
                                        <button
                                          className="btn btn-lg btn-primary"
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
                                  <tfoot>
                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Amount
                                      </th>
                                      <td>
                                        {itemGrandTotal} {currency_symbol}
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
                                          value={advanceAmt}
                                          onChange={handleAdvanceCalculate}
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
                                          value={dueAmt}
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
                                        {formatCurrency(finalDiscountAmt)}{" "}
                                        {currency_symbol}
                                      </td>
                                    </tr>

                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        Tax ({InsertData.tax_percentage})%
                                      </th>
                                      <td>{formatCurrency(totalWithTax)}</td>
                                    </tr>

                                    <tr>
                                      <th colSpan={6} className="text-end">
                                        <strong>Grand Total</strong>
                                      </th>
                                      <td>
                                        {convGrandTotal} {currency_symbol}
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

                          {/* InsertData Particular Tab */}
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
                    <div className="d-flex justify-content-end gap-2">
                      <button
                        type="button"
                        className="btn btn-danger"
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
                  <div className="modal-footer"></div>
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

export default CreateInvoice;
