// index.js
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config();

// Routes
const quizRoutes = require("./routes/quizRoutes");
const userRoutes = require("./routes/userRoutes");

const app = express();

// ================= Middleware =================
app.use(cors());          // Enable CORS for Flutter Web / mobile apps
app.use(express.json());  // Parse JSON requests

// ================= Test Route =================
app.get("/api/hello", (req, res) => {
  res.status(200).json({ message: "Hello from backend ✅" });
});

// ================= API Routes =================
app.use("/api/quiz", quizRoutes);
app.use("/api/users", userRoutes);

// ================= MongoDB Connection =================
const MONGO_URI = process.env.MONGO_URI || "mongodb://127.0.0.1:27017/quizDB";
const PORT = process.env.PORT || 5000;
const LOCAL_IP = process.env.LOCAL_IP || "192.168.29.5"; // replace with your PC IP

mongoose
  .connect(MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("✅ MongoDB connected successfully");

    // Start server
    app.listen(PORT, "0.0.0.0", () => {
      console.log(`🚀 Server running on http://0.0.0.0:${PORT}`);
      console.log(`👉 Android Emulator: http://10.0.2.2:${PORT}`);
      console.log(`👉 Web/Desktop: http://localhost:${PORT}`);
      console.log(`👉 Physical device: http://${LOCAL_IP}:${PORT}`);
    });
  })
  .catch((err) => {
    console.error("❌ MongoDB connection error:", err.message);
    process.exit(1);
  });

// ================= Global Error Handler (Optional) =================
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: "Something went wrong!" });
});
