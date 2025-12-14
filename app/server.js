const express = require("express");
const mongoose = require("mongoose");

const app = express();
app.use(express.json());

// MongoDB Connection
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB connected"))
  .catch(err => console.error(err));

// Schema
const UserSchema = new mongoose.Schema({
  name: String,
  email: String
});

const User = mongoose.model("User", UserSchema);

// Routes
app.get("/", (req, res) => {
  res.send("Node + Mongo App Running 🚀");
});

app.post("/users", async (req, res) => {
  const user = await User.create(req.body);
  res.status(201).json(user);
});

app.get("/users", async (req, res) => {
  const users = await User.find();
  res.json(users);
});

// Server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () =>
  console.log(`Server running on port ${PORT}`)
);
