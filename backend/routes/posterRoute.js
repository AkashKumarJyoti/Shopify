import express from 'express';
import {getAllPoster, getPosterById, addNewPoster, updatePosterById, deletePosterById} from '../controllers/posterController.js';

const posterRouter = express.Router();

posterRouter.get('/', getAllPoster);
posterRouter.get('/:id', getPosterById);
posterRouter.post('/', addNewPoster);
posterRouter.put('/:id', updatePosterById);
posterRouter.delete('/:id', deletePosterById);

export default posterRouter;