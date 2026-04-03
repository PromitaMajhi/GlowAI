# GlowAI - AI Powered Skincare Assistant App

A modern, premium mobile application that provides personalized AI skincare advice, complete with a Node.js Express backend and Flutter frontend.

## Tech Stack
- **Frontend**: Flutter
- **Backend**: Node.js (Express)
- **Database**: MongoDB
- **AI Integration**: OpenAI (gpt-3.5-turbo)

## Folders
- `backend/`: Node.js server to handle API calls to OpenAI and connect to MongoDB.
- `frontend/`: Flutter app with premium UI for chat and product recommendations.

## Easy to Run Instructions

### 1. Backend Setup
1. Verify that **Node.js** (v16+) and **MongoDB** are installed and running on your system.
2. Open a terminal and navigate to the backend folder:
   ```bash
   cd backend
   ```
3. Install dependencies:
   ```bash
   npm install
   ```
4. Configure Environment Variables:
   - Open `backend/.env`
   - Set your `OPENAI_API_KEY` to your valid OpenAI key.
   - Adjust `MONGODB_URI` if necessary.
5. Start the server:
   ```bash
   npm start
   ```
   *The server should run on http://localhost:5000*

### 2. Frontend Setup
1. Verify that **Flutter SDK** is installed and configured.
2. Ensure you have an Android emulator running or a connected device.
3. Open a new terminal and navigate to the frontend folder:
   ```bash
   cd frontend
   ```
4. If this is a fresh Flutter clone without the platform folders generated, initialize them:
   ```bash
   flutter create .
   ```
5. Fetch the flutter dependencies:
   ```bash
   flutter pub get
   ```
6. Run the app:
   ```bash
   flutter run
   ```

*(Note: In `api_service.dart`, the `baseUrl` is set to `http://10.0.2.2:5000`, which correctly routes traffic from an Android Emulator to your computer's localhost. If using iOS, change it to `http://127.0.0.1:5000` or `http://localhost:5000`)*
