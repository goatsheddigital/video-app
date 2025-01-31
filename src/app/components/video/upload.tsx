// allow the user to upload a video without the video

export default async function VideoUpload() {
    // get the video from the user
    const video = await getVideo();
    // upload the video to the backend
    const response = await uploadVideo(video);
    // return the response
    return response;
}
function getVideo() {
    // get a random vidoe from the video generator
    return {
        title: "Video 1",
        description: "This is video 1",
        uri: "video1",
        avatar: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    };
}
function uploadVideo(video: any) {
    //random values video metadata
    return {
        title: "Video 1",
        description: "This is video 1",
        uri: "video1",
        avatar: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    };
    
}
