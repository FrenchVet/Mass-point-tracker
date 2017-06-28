filename = 'pompkaTrimTrim.mp4'; 
vid = VideoReader(filename); 
newVid = VideoWriter('NewVid');

open(newVid);
numFrames = vid.NumberOfFrames;
for frame = 1 : numFrames
    % Extract the frame from the movie structure.
    thisFrame = read(vid, frame); 
    %Convert each frame to black and white
    gray = rgb2gray(thisFrame); 
    gray = gray(1:2:end,1:2:end);
    writeVideo(newVid,gray); 

end

close(newVid); 