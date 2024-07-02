/*
  a) Get all posters
  b) Get all poster by id.
  c) Create new poster.
  d) Update poster by id.
  e) Delete poster by id.
*/

import Poster from '../models/posterModel.js';
import asyncHandler from 'express-async-handler';
import multer from 'multer';
import {uploadPosters} from '../uploadFile.js';

// Get all posters
const getAllPoster = asyncHandler(async (req, res) => {
  try {
    const posters = await Poster.find({});
    return res.json({ success: true, message: "Posters retrieved successfully.", data: posters });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Get poster by id
const getPosterById = asyncHandler(async (req, res) => {
  try {
    const posterID = req.params.id;
    const poster = await Poster.findById(posterID);
    if (!poster) {
        return res.status(404).json({ success: false, message: "Poster not found." });
    }
    return res.json({ success: true, message: "Poster retrieved successfully.", data: poster });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Create new poster
const addNewPoster = asyncHandler(async (req, res) => {
  try {
    uploadPosters.single('img')(req, res, async function (err) {
      if (err instanceof multer.MulterError) {
          if (err.code === 'LIMIT_FILE_SIZE') {
              err.message = 'File size is too large. Maximum filesize is 5MB.';
          }
          console.log(`Add poster: ${err}`);
          return res.json({ success: false, message: err });
      } else if (err) {
          console.log(`Add poster: ${err}`);
          return res.json({ success: false, message: err });
      }
      const { posterName } = req.body;
      let imageUrl = 'no_url';
      if (req.file) {
          imageUrl = `http://localhost:3000/image/poster/${req.file.filename}`;
      }

      if (!posterName) {
          return res.status(400).json({ success: false, message: "Name is required." });
      }

      try {
          const newPoster = new Poster({
              posterName: posterName,
              imageUrl: imageUrl
          });
          await newPoster.save();
          res.json({ success: true, message: "Poster created successfully.", data: null });
      } catch (error) {
          console.error("Error creating Poster:", error);
          res.status(500).json({ success: false, message: error.message });
      }
  });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Update poster by id
const updatePosterById = asyncHandler(async (req, res) => {
  try {
    const posterID = req.params.id;
    uploadPosters.single('img')(req, res, async function (err) {
      if (err instanceof multer.MulterError) {
          if (err.code === 'LIMIT_FILE_SIZE') {
              err.message = 'File size is too large. Maximum filesize is 5MB.';
          }
          console.log(`Update poster: ${err.message}`);
          return res.json({ success: false, message: err.message });
      } else if (err) {
          console.log(`Update poster: ${err.message}`);
          return res.json({ success: false, message: err.message });
      }

      const { posterName } = req.body;
      let image = req.body.image;


      if (req.file) {
          image = `http://localhost:3000/image/poster/${req.file.filename}`;
      }

      if (!posterName || !image) {
          return res.status(400).json({ success: false, message: "Name and image are required." });
      }

      try {
          const updatedPoster = await Poster.findByIdAndUpdate(posterID, { posterName: posterName, imageUrl: image }, { new: true });
          if (!updatedPoster) {
              return res.status(404).json({ success: false, message: "Poster not found." });
          }
          res.json({ success: true, message: "Poster updated successfully.", data: null });
      } catch (error) {
          res.status(500).json({ success: false, message: error.message });
      }

    });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

// Delete poster by id
const deletePosterById = asyncHandler(async (req, res) => {
  try {
    const posterID = req.params.id;
    const deletedPoster = await Poster.findByIdAndDelete(posterID);
    if (!deletedPoster) {
      return res.status(404).json({ success: false, message: "Poster not found." });
    }
    res.json({ success: true, message: "Poster deleted successfully." });
  } catch (error) {
    return res.status(500).json({success: false, message: error.message});
  }
});

export {getAllPoster, getPosterById, addNewPoster, updatePosterById, deletePosterById};