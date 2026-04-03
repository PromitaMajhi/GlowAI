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
  apiKey: process.env.GROQ_API_KEY,
  baseURL: 'https://api.groq.com/openai/v1',
});

app.post('/ask', async (req, res) => {
  try {
    const { message } = req.body;
    
    if (!message) {
      return res.status(400).json({ error: 'Message is required' });
    }

    const systemPrompt = `You are a highly advanced AI dermatologist and skincare expert named GlowAI.
Analyze the user's input (which could be a skin problem, an ingredient list, weather conditions, or voice note) and provide a JSON response exactly like this:
{
  "analysis": "Detailed explanation of their condition or the ingredients they sent",
  "routine": {
    "morning": "Morning step-by-step",
    "night": "Night step-by-step"
  },
  "tips": ["Tip 1", "Tip 2", "Weather/Diet tip"],
  "products": [
    {
      "name": "Product Name",
      "description": "Why it works",
      "buyLink": "https://www.amazon.com/s?k=skincare"
    }
  ],
  "needsDoctor": false // Set to true ONLY if they mention severe acne, bleeding, extreme allergies
}
Keep tips very practical and provide exactly 3 valid product recommendations. NEVER break the JSON format.`;

    const completion = await openai.chat.completions.create({
      model: 'llama-3.3-70b-versatile',
      messages: [
        { role: 'system', content: systemPrompt },
        { role: 'user', content: message }
      ],
      temperature: 0.7,
      max_tokens: 1000,
    });

    let replyText = completion.choices[0].message.content;
    // Extract JSON from markdown code blocks if present
    const jsonMatch = replyText.match(/```(?:json)?\s*([\s\S]*?)```/);
    if (jsonMatch) replyText = jsonMatch[1];
    const replyJson = JSON.parse(replyText.trim());

    res.json({ reply: replyJson });
  } catch (error) {
    console.error('Error generating AI response:', error);
    res.status(500).json({ error: 'Something went wrong. Please try again.' });
  }
});

app.listen(PORT, () => {
  console.log(`GlowAI Backend running on http://localhost:${PORT}`);
});
