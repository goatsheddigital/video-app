// src/app/feed/feed.tsx
import { agent } from "~/lib/api";



export default async function PopularFeeds() {
    // get user's popular feeds
    let {data: {feeds}} = await agent.app.bsky.unspecced.getPopularFeedGenerators({
        limit: 100,
    });

    return (
        
        <div>
            {feeds.map((feed) => (
                <div key={feed.uri} className="my-2">
                    <a href={`/feed/${feed.uri}`}>{feed.displayName}</a>
                    <div className="text-sm text-gray-500">{feed.description}</div>
                    {/* details below */}
                    {/* avatar */}
                    <img src={feed.avatar} alt={feed.displayName} width={40} className="w-1 h-1 rounded-full" />
                    
                    {/* description */}
                    
                    {/* uri */}
                    <div className="text-xs text-gray-400">{feed.uri}</div>
                    
                    {/* displayName */}
                    
                </div>
            ))}
        </div>
    );
}
