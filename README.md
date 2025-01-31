This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.

That’s a great approach—using **Vercel for quick deployments** keeps everything public and transparent as you build. Since you started with the **my-bsky sample app**, you already have a foundation. Now, let’s break down:  

- **What you need to build** (new components for video recommendations)  
- **What you can leverage** (existing Bluesky & AT Protocol features)  
- **Next steps** for integrating and testing ASAP  

---

## **1. What You Need to Build (Custom Components)**
Since you’re focusing on **video recommendations**, here are the key components you’ll need:  

### **A. Feed Generator (Backend)**
A **custom Bluesky Feed Generator** that serves personalized video recommendations.  
🔹 Runs as a **separate API service** (which is great since you're deploying with Vercel).  
🔹 Uses **AT Protocol APIs** to pull user interactions (likes, follows, etc.).  
🔹 Returns **a personalized feed** of video posts.  

### **B. Video Post Structure (Data Format)**
You’ll need to define **how video posts are stored and referenced** in the AT Protocol.  
🔹 A **new record type** for video posts (or extend the existing `app.bsky.feed.post`).  
🔹 Store **metadata like video URL, title, thumbnail, and tags**.  
🔹 Make sure it fits into Bluesky’s existing **data schema** so it works seamlessly.  

### **C. Frontend UI (Optional for MVP)**
Since you're using **my-bsky**, you could modify it to:  
🔹 Add a **"Video Feed" tab** that loads video posts from your feed generator.  
🔹 Display a **basic embedded video player** in posts.  
🔹 Show **engagement actions** (like, comment, share).  

---

## **2. What You Can Leverage (Existing Components)**
Instead of reinventing the wheel, you can take advantage of existing Bluesky & AT Protocol features:  

✅ **AT Protocol APIs** → Fetch user activity (likes, follows, posts).  
✅ **Bluesky’s Feed Generator Framework** → Easily plug in your custom video feed.  
✅ **Existing Post Record (`app.bsky.feed.post`)** → Modify or extend it for video posts.  
✅ **Bluesky UI Components (if modifying my-bsky)** → Use their styling & structure.  

---

## **3. Next Steps: Get a Minimal Testable Version Up**
### **Step 1: Set Up a Basic Feed Generator (Vercel-Ready)**
Since you’re deploying on Vercel, start with a **simple API** that returns a static feed of videos.  

👉 **Modify `my-bsky` to request this feed.**  

Here’s a minimal **FastAPI-based feed generator** (which works well with Vercel's serverless model):  

📂 **File: `feed_generator.py`**  
```python
from fastapi import FastAPI
from typing import List

app = FastAPI()

@app.get("/video-feed")
def get_video_feed() -> List[dict]:
    return [
        {
            "uri": "at://did:plc:example/video123",
            "cid": "bafy...xyz",
            "author": "did:plc:example-user",
            "record": {
                "type": "app.bsky.feed.post",
                "createdAt": "2025-01-31T12:00:00Z",
                "text": "Check out this cool video!",
                "embed": {
                    "type": "app.bsky.embed.external",
                    "uri": "https://example.com/video.mp4",
                    "title": "Awesome Video",
                    "thumb": "https://example.com/thumbnail.jpg"
                }
            }
        }
    ]
```
🚀 **Deploy this to Vercel and get a URL (e.g., `https://your-app.vercel.app/video-feed`)**  

---

### **Step 2: Modify `my-bsky` to Pull Your Feed**
In your **my-bsky** app, modify the **feed request logic** to fetch from your video feed:  

📂 **File: `src/screens/FeedScreen.tsx`**
```tsx
const fetchVideoFeed = async () => {
    const response = await fetch("https://your-app.vercel.app/video-feed");
    const data = await response.json();
    setPosts(data);
};
```
🔹 Now, when you open the app, it should **pull test videos from your Vercel API**.  

---

### **Step 3: Verify That Bluesky Can Read Your Feed**
To integrate this as a proper **Bluesky Feed Generator**, you’ll need to:  
- Follow **Bluesky’s Feed Generator API**  
- Register the feed so users can **subscribe to it in Bluesky**  

👉 **Reference:** [Bluesky Feed Generator Guide](https://github.com/bluesky-social/feed-generator)  

---

## **Final Deliverables for MVP**
✅ **Basic feed generator running on Vercel**  
✅ **Video feed appearing in `my-bsky` app**  
✅ **Feed returns simple test data (static list of videos)**  
🔲 **Bluesky recognizes the feed as a valid source**  
🔲 **Fetch real user interactions to improve recommendations**  

---

## **Final Thought**
You’re on track for **a quick MVP** by focusing on a **feed generator** first.  
Once that works:  
- **Improve recommendation logic**  
- **Fetch real user data**  
- **Add video hosting & playback**  

Would you like me to **help with defining the video post schema** for AT Protocol next? 🚀