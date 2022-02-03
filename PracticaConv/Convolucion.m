clear;
clc;
recObj = audiorecorder;

disp("Start recording");
disp('Start speaking.');
recordblocking(recObj, 5); disp('End of Recording.');
play(recObj);
mtzaudio = getaudiodata(recObj);
plot(mtzaudio);