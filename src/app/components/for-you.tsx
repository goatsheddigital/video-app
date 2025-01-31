import { agent} from "~/lib/api";


export default async function ForYou() {

   
     // get user's popublar feeds


    const {data: {feeds}} = await agent.app.bsky.unspecced.getPopularFeedGenerators({ limit: 1, });



  return (
    // fill the screen with the item returned
    <div className="container mx-auto h-screen w-screen bg-gray-100 p-4 height-full overflow-y-auto flex flex-col h-100">
      {feeds.map((feed) => (
        <div  key={feed.uri} className="my-2 flex flex-col">
          <a href={`/feed/${feed.uri}`}>{feed.displayName}</a>
          <div className="text-sm text-gray-500">{feed.description}</div>
          {/* details below */}
          {/* avatar */}
          <image  href={feed.avatar} name={feed.displayName} width={40} className="w-1 h-1 rounded-full" />
          {/* description */}
          {/* uri */}
          <div className="text-xs text-gray-400">{feed.uri}</div>
          {/* displayName */}
        </div>)
        )}
    </div>
  );
}