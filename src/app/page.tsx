// src/app/page.tsx
import ForYou from "./components/for-you";
import Servers from "./components/servers";

export default async function Homepage() {


  return (
    <div className="container mx-auto">
      <h1 className="font-bold text-xl my-4">Top Feeds</h1>
          <ForYou/>
          <Servers/>
    </div>
  );
}