require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
const { OpenAI } = require('openai');

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 5000;

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/glowai')
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.error('MongoDB connection error:', err));

const openai = new OpenAI({
  apiKey: process.env.OPENROUTER_API_KEY,
  baseURL: 'https://openrouter.ai/api/v1',
  defaultHeaders: {
    'HTTP-Referer': 'http://localhost:5000',
    'X-Title': 'GlowAI Skincare Assistant',
  },
});

app.post('/ask', async (req, res) => {
  try {
    const { message } = req.body;
    
    if (!message) {
      return res.status(400).json({ error: 'Message is required' });
    }

    const systemPrompt = `You are a professional skincare expert.
Analyze the user's skin concern and provide EXACTLY a valid JSON response with the following structure:
{
  "analysis": "Short skin analysis",
  "routine": {
    "morning": "Morning routine steps",
    "night": "Night routine steps"
  },
  "tips": ["Useful tip 1", "Useful tip 2"],
  "products": [
    {
      "name": "Product Name",
      "description": "Short reason",
      "buyLink": "https://www.amazon.com/s?k=skincare"
    }
  ]
}
Ensure exactly 3 product recommendations with simple search links. Keep answers safe, simple, and non-medical.`;

    const completion = await openai.chat.completions.create({
      model: 'openai/gpt-3.5-turbo',
      messages: [
        { role: 'system', content: systemPrompt },
        { role: 'user', content: message }
      ],
      temperature: 0.7,
      max_tokens: 800,
      response_format: { type: "json_object" }
    });

    const replyText = completion.choices[0].message.content;
    const replyJson = JSON.parse(replyText);

    res.json({ reply: replyJson });
  } catch (error) {
    console.error('Error generating AI response:', error);
    res.status(500).json({ error: 'Something went wrong. Please try again.' });
  }
});

app.listen(PORT, () => {
  console.log(`GlowAI Backend running on http://localhost:${PORT}`);
});
