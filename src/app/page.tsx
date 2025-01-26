// src/app/page.tsx
import { agent } from "~/lib/api";
import PopularFeeds from "./feed/feed";
import ForYou from "./components/for-you";

export default async function Homepage() {
  const feeds = await agent.app.bsky.unspecced.getPopularFeedGenerators({
    limit: 100,
  }
);

  return (
    <div className="container mx-auto">
      <h1 className="font-bold text-xl my-4">Top Feeds</h1>
          <ForYou/>
          {/* <PopularFeeds/> */}

          {/* show first feed  */}
          <div>
            
            <a href={`/feed/${feeds.data.feeds[0].uri}`}>
              {feeds.data.feeds[0].viewer?.like} {feeds.data.feeds[0].displayName}
            </a>
          </div>
    </div>
  );
}