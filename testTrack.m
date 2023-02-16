clearvars
clc

fn = '../data/WL_1_well E05.tif';

imgData = imfinfo(fn);
nFrames = numel(imgData);

tracker = LAPLinker;
tracker.LinkScoreRange = [0 30];

%Generate a movie
vid = VideoWriter('test.avi');
vid.FrameRate = 5;
open(vid);

for iT = 1:nFrames

    I = imread(fn, iT);
    mask = dogfilter(I);

    stats = regionprops(mask, 'Centroid');

    tracker = assignToTrack(tracker, iT, stats);

    %Generate a movie
    for iAT = 1:numel(tracker.activeTrackIDs)

        ct = getTrack(tracker, tracker.activeTrackIDs(iAT));

        Idbl = double(I);
        Idbl = (Idbl - min(Idbl(:)))/(max(Idbl(:)) - min(Idbl(:)));

        I = insertShape(Idbl, 'FilledCircle', [ct.Centroid(end, :), 2]);
        
    end
    writeVideo(vid, Idbl); 
    
end

close(vid)

save('testoutput.mat', 'tracker')