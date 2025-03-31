import React, { useState, useEffect, useContext } from "react";
import { Link } from "react-router-dom";
import { LanguageContext } from "../context/LanguageContext";
const Footer = () => {
  const { content } = useContext(LanguageContext);
  return (
    <>
        <footer className="page-footer">
            <p className="mb-0">Copyright © 2024. All right reserved.</p>
          </footer>
    </>
  );
};

export default Footer;
