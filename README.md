# ChessCrypt DApp - Decentralized Chess Steganography

A decentralized application that combines chess-based steganography with blockchain technology, allowing users to hide and retrieve secret messages inside valid PGN chess game files.

## 🎯 Features

- **Chess-based Steganography**: Hide messages in valid, playable chess games
- **Coinbase Wallet Integration**: Secure wallet connection using Wallet SDK
- **X402 Micropayments**: Small crypto transactions for encoding/decoding
- **Self-Destructing Messages**: Optional expiry times for enhanced security
- **Blockchain Storage**: Decentralized storage of PGN metadata
- **React Frontend**: Modern, responsive user interface
- **Open Source**: Built entirely with free, open-source libraries

## 🏗️ Architecture

### Backend (Python Flask)
- **Chess Library**: `python-chess` for PGN manipulation
- **Steganography**: Custom algorithm hiding data in chess moves
- **Blockchain Integration**: X402 protocol for micropayments
- **API Endpoints**: RESTful API for wallet, payment, and file operations

### Frontend (React)
- **UI Framework**: React with Tailwind CSS
- **Chess Visualization**: `react-chessboard` and `chess.js`
- **Wallet Integration**: Coinbase Wallet SDK
- **Web3 Integration**: Web3.js for blockchain interactions

## 🚀 Quick Start

### Prerequisites
- Python 3.8+
- Node.js 16+
- npm or yarn

### 1. Backend Setup

```bash
# Clone and setup Python environment
git clone <repository-url>
cd ROOKHIDE_LOCAL
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

### 2. Start Backend Server (api_server)

Option A: Production-like via Gunicorn
```bash
export PORT=8000 FLASK_ENV=production FLASK_DEBUG=0
gunicorn -c gunicorn.conf.py api_server:app
```
Backend will run on `http://localhost:8000`

Option B: Dev runner
```bash
PORT=8000 python api_server.py
```

### 3. Frontend Setup

```bash
# Install dependencies
cd frontend
npm install
```

### 4. Configure Environment

Create `frontend/.env`:
```env
REACT_APP_API_URL=http://localhost:8001
PORT=3000
REACT_APP_COINBASE_APP_NAME=ChessCrypt DApp
REACT_APP_ENABLE_WALLET_CONNECT=true
REACT_APP_ENABLE_X402_PAYMENTS=true
```

### 5. Start Frontend

```bash
# Run the React frontend
npm start
```
Frontend will run on `http://localhost:3000`

## 📡 API Endpoints

### Health & Authentication
- `GET /api/health` - Health check
- `POST /api/wallet/connect` - Connect Coinbase Wallet

### X402 Payments
- `POST /api/payment/initiate` - Initiate micropayment
- `POST /api/payment/verify` - Verify payment completion

### Steganography Operations
- `POST /api/encode` - Encode message in chess game
- `POST /api/decode` - Decode message from PGN
- `POST /api/pgn/validate` - Validate PGN file

### File Management
- `GET /api/download/<pgn_id>` - Download PGN file
- `GET /api/pgn/metadata/<pgn_id>` - Get PGN metadata
- `GET /api/pgn/list` - List user's PGN files

## 🔧 How It Works

### Encoding Process
1. **Wallet Connection**: User connects Coinbase Wallet
2. **File Upload**: User selects file to hide (text/image)
3. **Payment**: X402 micropayment for encoding service (0.002 ETH)
4. **Steganography**: File data encoded into chess moves
5. **PGN Generation**: Valid chess game created with hidden data
6. **Blockchain Storage**: Metadata stored with transaction hash

### Decoding Process
1. **PGN Upload**: User uploads encoded PGN file
2. **Payment**: X402 micropayment for decoding service (0.001 ETH)
3. **Validation**: Verify PGN contains hidden data
4. **Extraction**: Decode hidden message from chess moves
5. **File Recovery**: Original file reconstructed and downloaded

### Chess Steganography Algorithm
- Each chess position offers multiple legal moves
- Number of legal moves determines bits that can be encoded
- Move selection encodes binary data while maintaining valid game
- Self-destruct timer adds expiry metadata to PGN headers
- Games remain playable on any chess platform

## 🔐 Security Features

- **Wallet Signatures**: Cryptographic proof of ownership
- **File Hashing**: SHA-256 integrity verification
- **Expiry Times**: Self-destructing messages
- **Blockchain Verification**: Transaction-based access control
- **Open Source**: Transparent, auditable code

## 🛠️ Project Structure

```
ROOKHIDE_LOCAL/
├── api_server.py         # Minimal API server for production
├── app.py               # Full Flask backend with templates
├── encode.py            # Encoding logic
├── decode.py            # Decoding logic
├── blockchain.py        # Blockchain integration
├── util.py             # Utility functions
├── requirements.txt     # Python dependencies
├── .env                # Environment variables
├── frontend/
│   ├── src/
│   │   ├── components/  # React components
│   │   ├── App.js      # Main React app
│   │   └── config.js   # API configuration
│   ├── public/         # Static assets
│   ├── package.json    # Node dependencies
│   └── .env           # Frontend environment
├── templates/          # Flask HTML templates
├── static/            # Static assets for Flask
├── uploads/           # Temporary file uploads
├── outputs/           # Generated PGN files
└── blockchain_storage/ # Decentralized storage
```

## 🎮 Usage

### 1. Connect Wallet
- Click "Connect Wallet" in the top right
- Approve connection in your Coinbase Wallet
- Wallet address will be displayed when connected

### 2. Encode a Message
- Go to "Encode" tab
- Upload a text file or image
- Configure optional settings (self-destruct timer, PGN headers)
- Complete X402 payment (0.002 ETH)
- Download the generated PGN file

### 3. Decode a Message
- Go to "Decode" tab
- Upload a PGN file with hidden data
- Complete X402 payment (0.001 ETH)
- Download the extracted file

### 4. Chess Game Compatibility
- Generated PGN files are valid chess games
- Can be imported into any chess software
- Games are playable and follow chess rules
- Hidden data is invisible to standard chess tools

## 🌐 Deployment

### Option A: Docker (recommended)

Build and run locally:
```bash
docker build -t chesscrypt:latest .
docker run --rm -p 8000:8000 --env-file .env chesscrypt:latest
```

- Default entrypoint serves api_server via Gunicorn at 0.0.0.0:8000
- To run the legacy Flask templates app instead, override APP_MODULE:
```bash
docker run --rm -p 8000:8000 -e APP_MODULE=app:app --env-file .env chesscrypt:latest
```

Health check:
```bash
curl http://localhost:8000/api/health
```

### Option B: Render (one-click)

- Commit and push this repo to GitHub
- Create a new Web Service from repo
- Render will detect render.yaml and use the Dockerfile
- Default env vars included; add your own secrets as needed

### Option C: Procfile-compatible PaaS

- Uses the included Procfile to start Gunicorn:
```bash
web: gunicorn -c gunicorn.conf.py api_server:app
```

### Frontend Deployment (React)
- Build: `npm run build` (in frontend directory)
- Vercel/Netlify: set `REACT_APP_API_URL` to your deployed backend URL
- Recommended env for frontend/.env:
```env
REACT_APP_API_URL=https://your-backend.onrender.com
REACT_APP_COINBASE_APP_NAME=ChessCrypt DApp
REACT_APP_ENABLE_WALLET_CONNECT=true
REACT_APP_ENABLE_X402_PAYMENTS=true
```

### Environment Variables

#### Backend (.env)
```env
PORT=8000
FLASK_ENV=production
FLASK_DEBUG=0
# Restrict CORS in production (comma-separated origins)
# CORS_ORIGINS=https://your-frontend.vercel.app
# Required secret in production
# SECRET_KEY=change-me
# X402 pricing and wallet
# X402_ENCODE_PRICE=2000000000000000
# X402_DECODE_PRICE=1000000000000000
# PAYMENT_WALLET_ADDRESS=0x742d35Cc6634C0532925a3b8D4C9db96590c6C87
```

#### Frontend (frontend/.env)
```env
REACT_APP_API_URL=https://your-api-domain.com
REACT_APP_COINBASE_APP_NAME=ChessCrypt DApp
REACT_APP_ENABLE_WALLET_CONNECT=true
REACT_APP_ENABLE_X402_PAYMENTS=true
```

## 🧪 Testing

### Health Check
```bash
curl http://localhost:8000/api/health
```

### Wallet Connection Test
1. Open the DApp in browser
2. Click "Connect Wallet"
3. Check browser console for connection logs

## 🤝 Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- **python-chess**: Excellent chess library for Python
- **Coinbase Wallet SDK**: Free wallet integration
- **chess.js**: JavaScript chess library
- **React Chessboard**: Beautiful chess UI components
- **Tailwind CSS**: Utility-first CSS framework

## 🔗 Links

- [Chess.com PGN Format](https://www.chess.com/terms/pgn-portable-game-notation)
- [Coinbase Wallet SDK](https://docs.cloud.coinbase.com/wallet-sdk/docs)

---

**Built with ♟️ and 🔐 for the decentralized future**