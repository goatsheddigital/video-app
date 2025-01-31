// display the top video

import exp from "constants";
import VideoGenerator from "../backend/generators/videoGenerator";


// import backend generators video generator

/// return the top video from the backend
export async function TopVideo() {
    const videos = await VideoGenerator();
    return videos[0];

}

export default async function ForYou() {
    const video = await TopVideo();
    return (
        <div>
            <div className="my-2">
                <a href={`/video/${video.uri}`}>{video.title}</a>
                <div className="text-sm text-gray-500">{video.description}</div>
                <image href={video.avatar} name={video.title} width={40} className="w-1 h-1 rounded-full" />
                <div className="text-xs text-gray-400">{video.title}</div>
            </div>
        </div>
    );

// display the top video
}

