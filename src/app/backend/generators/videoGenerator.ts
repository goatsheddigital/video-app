// Backend Feed Generator
// This file is responsible for generating the feed for the backend
//
// mock the feed to start the backend

export default async function VideoGenerator() {
    // get random videos to send to the frontend
    const videos = [
        {
            title: "Video 1",
            description: "This is video 1",
            uri: "video1",
            avatar: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        },
        {
            title: "Video 2",
            description: "This is video 2",
            uri: "video2",
            avatar: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        },
        {
            title: "Video 3",
            description: "This is video 3",
            uri: "video3",
            avatar: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        },
    ];
    return videos;
}
// Backend Feed Generator