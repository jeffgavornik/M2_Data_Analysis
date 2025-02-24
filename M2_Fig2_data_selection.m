dataPath = './Data/M2 data';
figPath = './Figures/M2 Fig2 Results';
[~,~,~] = mkdir(figPath);

extractTimeWindow = 0.6;

expDay1Files = struct;
expDay1Files(1).name = '600556o3_seqday1.plx';
expDay1Files(1).channelNumber = 2;
expDay1Files(1).folder = dataPath;
expDay1Files(2).name = '609015o1_seqday1.plx';
expDay1Files(2).channelNumber = 1;
expDay1Files(2).folder = dataPath;
expDay1Files(3).name = '608948o4_seqday1.plx';
expDay1Files(3).channelNumber = 2;
expDay1Files(3).folder = dataPath;
expDay1Files(4).name = '610422o1_seqday1.plx';
expDay1Files(4).channelNumber = 1;
expDay1Files(4).folder = dataPath;
expDay1Files(5).name = '610422o2_seqday1.plx';
expDay1Files(5).channelNumber = 1;
expDay1Files(5).folder = dataPath;
expDay1Files(6).name = '612554o1_seqday1.plx';
expDay1Files(6).channelNumber = 2;
expDay1Files(6).folder = dataPath;
expDay1Files(7).name = '612554o2_seqday1.plx';
expDay1Files(7).channelNumber = 1;
expDay1Files(7).folder = dataPath;
expDay1Files(8).name = '612554o3_seqday1.plx';
expDay1Files(8).channelNumber = 2;
expDay1Files(8).folder = dataPath;
expDay1Files(9).name = '401278o1_seqday1.plx';
expDay1Files(9).channelNumber = 1;
expDay1Files(9).folder = dataPath;
expDay1Files(10).name = '401278o2_seqday1.plx';
expDay1Files(10).channelNumber = 1;
expDay1Files(10).folder = dataPath;
expDay1Files(11).name = '604147o1_seqday1.plx';
expDay1Files(11).channelNumber = 2;
expDay1Files(11).folder = dataPath;
expDay1Files(12).name = '604147o4_seqday1.plx';
expDay1Files(12).channelNumber = 2;
expDay1Files(12).folder = dataPath;


expDay2Files = struct;
expDay2Files(1).name = '600556o3_seqday2.plx';
expDay2Files(1).channelNumber = 2;
expDay2Files(1).folder = dataPath;
expDay2Files(2).name = '609015o1_seqday2.plx';
expDay2Files(2).channelNumber = 1;
expDay2Files(2).folder = dataPath;
expDay2Files(3).name = '608948o4_seqday2.plx';
expDay2Files(3).channelNumber = 2;
expDay2Files(3).folder = dataPath;
expDay2Files(4).name = '610422o1_seqday2.plx';
expDay2Files(4).channelNumber = 1;
expDay2Files(4).folder = dataPath;
expDay2Files(5).name = '610422o2_seqday2.plx';
expDay2Files(5).channelNumber = 1;
expDay2Files(5).folder = dataPath;
expDay2Files(6).name = '612554o1_seqday2.plx';
expDay2Files(6).channelNumber = 2;
expDay2Files(6).folder = dataPath;
expDay2Files(7).name = '612554o2_seqday2.plx';
expDay2Files(7).channelNumber = 1;
expDay2Files(7).folder = dataPath;
expDay2Files(8).name = '612554o3_seqday2.plx';
expDay2Files(8).channelNumber = 2;
expDay2Files(8).folder = dataPath;
expDay2Files(9).name = '401278o1_seqday2.plx';
expDay2Files(9).channelNumber = 1;
expDay2Files(9).folder = dataPath;
expDay2Files(10).name = '401278o2_seqday2.plx';
expDay2Files(10).channelNumber = 1;
expDay2Files(10).folder = dataPath;
expDay2Files(11).name = '604147o1_seqday2.plx';
expDay2Files(11).channelNumber = 2;
expDay2Files(11).folder = dataPath;
expDay2Files(12).name = '604147o4_seqday2.plx';
expDay2Files(12).channelNumber = 2;
expDay2Files(12).folder = dataPath;


expDay3Files = struct;
expDay3Files(1).name = '600556o3_seqday3.plx';
expDay3Files(1).channelNumber = 2;
expDay3Files(1).folder = dataPath;
expDay3Files(2).name = '609015o1_seqday3.plx';
expDay3Files(2).channelNumber = 1;
expDay3Files(2).folder = dataPath;
expDay3Files(3).name = '608948o4_seqday3.plx';
expDay3Files(3).channelNumber = 2;
expDay3Files(3).folder = dataPath;
expDay3Files(4).name = '610422o1_seqday3.plx';
expDay3Files(4).channelNumber = 1;
expDay3Files(4).folder = dataPath;
expDay3Files(5).name = '610422o2_seqday3.plx';
expDay3Files(5).channelNumber = 1;
expDay3Files(5).folder = dataPath;
expDay3Files(6).name = '612554o1_seqday3.plx';
expDay3Files(6).channelNumber = 2;
expDay3Files(6).folder = dataPath;
expDay3Files(7).name = '612554o2_seqday3.plx';
expDay3Files(7).channelNumber = 1;
expDay3Files(7).folder = dataPath;
expDay3Files(8).name = '612554o3_seqday3.plx';
expDay3Files(8).channelNumber = 2;
expDay3Files(8).folder = dataPath;
expDay3Files(9).name = '401278o1_seqday3.plx';
expDay3Files(9).channelNumber = 1;
expDay3Files(9).folder = dataPath;
expDay3Files(10).name = '401278o2_seqday3.plx';
expDay3Files(10).channelNumber = 1;
expDay3Files(10).folder = dataPath;
expDay3Files(11).name = '604147o1_seqday3.plx';
expDay3Files(11).channelNumber = 2;
expDay3Files(11).folder = dataPath;
expDay3Files(12).name = '604147o4_seqday3.plx';
expDay3Files(12).channelNumber = 2;
expDay3Files(12).folder = dataPath;

expDay4Files = struct;
expDay4Files(1).name = '600556o3_seqday4.plx';
expDay4Files(1).channelNumber = 2;
expDay4Files(1).folder = dataPath;
expDay4Files(2).name = '609015o1_seqday4.plx';
expDay4Files(2).channelNumber = 1;
expDay4Files(2).folder = dataPath;
expDay4Files(3).name = '608948o4_seqday4.plx';
expDay4Files(3).channelNumber = 2;
expDay4Files(3).folder = dataPath;
expDay4Files(4).name = '610422o1_seqday4.plx';
expDay4Files(4).channelNumber = 1;
expDay4Files(4).folder = dataPath;
expDay4Files(5).name = '610422o2_seqday4.plx';
expDay4Files(5).channelNumber = 1;
expDay4Files(5).folder = dataPath;
expDay4Files(6).name = '612554o1_seqday4.plx';
expDay4Files(6).channelNumber = 2;
expDay4Files(6).folder = dataPath;
expDay4Files(7).name = '612554o2_seqday4.plx';
expDay4Files(7).channelNumber = 1;
expDay4Files(7).folder = dataPath;
expDay4Files(8).name = '612554o3_seqday4.plx';
expDay4Files(8).channelNumber = 2;
expDay4Files(8).folder = dataPath;
expDay4Files(9).name = '401278o1_seqday4.plx';
expDay4Files(9).channelNumber = 1;
expDay4Files(9).folder = dataPath;
expDay4Files(10).name = '401278o2_seqday4.plx';
expDay4Files(10).channelNumber = 1;
expDay4Files(10).folder = dataPath;
expDay4Files(11).name = '604147o1_seqday4.plx';
expDay4Files(11).channelNumber = 2;
expDay4Files(11).folder = dataPath;
expDay4Files(12).name = '604147o4_seqday4.plx';
expDay4Files(12).channelNumber = 2;
expDay4Files(12).folder = dataPath;


expDay5Files = struct;
fileNumber = 1;
expDay5Files(fileNumber).name = '600556o3_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 2;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '609015o1_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 1;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '608948o4_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 2;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '610422o1_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 1;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '610422o2_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 1;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '612554o1_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 2;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '612554o2_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 1;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '612554o3_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 2;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '401278o1_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 1;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '401278o2_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 1;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '604147o1_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 2;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '604147o4_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 2;
expDay5Files(fileNumber).folder = dataPath;

ctrlDay1Files = struct;
ctrlDay1Files(1).name = '600556o2_seqday1.plx';
ctrlDay1Files(1).channelNumber = 1;
ctrlDay1Files(1).folder = dataPath;
ctrlDay1Files(2).name = '609015o2_seqday1.plx';
ctrlDay1Files(2).channelNumber = 1;
ctrlDay1Files(2).folder = dataPath;
ctrlDay1Files(3).name = '609015o3_seqday1.plx';
ctrlDay1Files(3).channelNumber = 1;
ctrlDay1Files(3).folder = dataPath;
ctrlDay1Files(4).name = '608948o1_seqday1.plx';
ctrlDay1Files(4).channelNumber = 1;
ctrlDay1Files(4).folder = dataPath;
ctrlDay1Files(5).name = '608948o3_seqday1.plx';
ctrlDay1Files(5).channelNumber = 1;
ctrlDay1Files(5).folder = dataPath;
ctrlDay1Files(6).name = '610422o3_seqday1.plx';
ctrlDay1Files(6).channelNumber = 1;
ctrlDay1Files(6).folder = dataPath;
ctrlDay1Files(7).name = '604147o2_seqday1.plx';
ctrlDay1Files(7).channelNumber = 2;
ctrlDay1Files(7).folder = dataPath;
ctrlDay1Files(8).name = '604193o1_seqday1.plx';
ctrlDay1Files(8).channelNumber = 2;
ctrlDay1Files(8).folder = dataPath;
ctrlDay1Files(9).name = '604193o2_seqday1.plx';
ctrlDay1Files(9).channelNumber = 2;
ctrlDay1Files(9).folder = dataPath;
ctrlDay1Files(10).name = '604193o4_seqday1.plx';
ctrlDay1Files(10).channelNumber = 2;
ctrlDay1Files(10).folder = dataPath;
ctrlDay1Files(11).name = '606213o2_seqday1.plx';
ctrlDay1Files(11).channelNumber = 1;
ctrlDay1Files(11).folder = dataPath;


ctrlDay2Files = struct;
ctrlDay2Files(1).name = '600556o2_seqday2.plx';
ctrlDay2Files(1).channelNumber = 1;
ctrlDay2Files(1).folder = dataPath;
ctrlDay2Files(2).name = '609015o2_seqday2.plx';
ctrlDay2Files(2).channelNumber = 1;
ctrlDay2Files(2).folder = dataPath;
ctrlDay2Files(3).name = '609015o3_seqday2.plx';
ctrlDay2Files(3).channelNumber = 1;
ctrlDay2Files(3).folder = dataPath;
ctrlDay2Files(4).name = '608948o1_seqday2.plx';
ctrlDay2Files(4).channelNumber = 1;
ctrlDay2Files(4).folder = dataPath;
ctrlDay2Files(5).name = '608948o3_seqday2.plx';
ctrlDay2Files(5).channelNumber = 1;
ctrlDay2Files(5).folder = dataPath;
ctrlDay2Files(6).name = '610422o3_seqday2.plx';
ctrlDay2Files(6).channelNumber = 1;
ctrlDay2Files(6).folder = dataPath;
ctrlDay2Files(7).name = '604147o2_seqday2.plx';
ctrlDay2Files(7).channelNumber = 2;
ctrlDay2Files(7).folder = dataPath;
ctrlDay2Files(8).name = '604193o1_seqday2.plx';
ctrlDay2Files(8).channelNumber = 2;
ctrlDay2Files(8).folder = dataPath;
ctrlDay2Files(9).name = '604193o2_seqday2.plx';
ctrlDay2Files(9).channelNumber = 2;
ctrlDay2Files(9).folder = dataPath;
ctrlDay2Files(10).name = '604193o4_seqday2.plx';
ctrlDay2Files(10).channelNumber = 2;
ctrlDay2Files(10).folder = dataPath;
ctrlDay2Files(11).name = '606213o2_seqday2.plx';
ctrlDay2Files(11).channelNumber = 1;
ctrlDay2Files(11).folder = dataPath;

ctrlDay3Files = struct;
ctrlDay3Files(1).name = '600556o2_seqday3.plx';
ctrlDay3Files(1).channelNumber = 1;
ctrlDay3Files(1).folder = dataPath;
ctrlDay3Files(2).name = '609015o2_seqday3.plx';
ctrlDay3Files(2).channelNumber = 1;
ctrlDay3Files(2).folder = dataPath;
ctrlDay3Files(3).name = '609015o3_seqday3.plx';
ctrlDay3Files(3).channelNumber = 1;
ctrlDay3Files(3).folder = dataPath;
ctrlDay3Files(4).name = '608948o1_seqday3.plx';
ctrlDay3Files(4).channelNumber = 1;
ctrlDay3Files(4).folder = dataPath;
ctrlDay3Files(5).name = '608948o3_seqday3.plx';
ctrlDay3Files(5).channelNumber = 1;
ctrlDay3Files(5).folder = dataPath;
ctrlDay3Files(6).name = '610422o3_seqday3.plx';
ctrlDay3Files(6).channelNumber = 1;
ctrlDay3Files(6).folder = dataPath;
ctrlDay3Files(7).name = '604147o2_seqday3.plx';
ctrlDay3Files(7).channelNumber = 2;
ctrlDay3Files(7).folder = dataPath;
ctrlDay3Files(8).name = '604193o1_seqday3.plx';
ctrlDay3Files(8).channelNumber = 2;
ctrlDay3Files(8).folder = dataPath;
ctrlDay3Files(9).name = '604193o2_seqday3.plx';
ctrlDay3Files(9).channelNumber = 2;
ctrlDay3Files(9).folder = dataPath;
ctrlDay3Files(10).name = '604193o4_seqday3.plx';
ctrlDay3Files(10).channelNumber = 2;
ctrlDay3Files(10).folder = dataPath;
ctrlDay3Files(11).name = '606213o2_seqday3.plx';
ctrlDay3Files(11).channelNumber = 1;
ctrlDay3Files(11).folder = dataPath;

ctrlDay4Files = struct;
ctrlDay4Files(1).name = '600556o2_seqday4.plx';
ctrlDay4Files(1).channelNumber = 1;
ctrlDay4Files(1).folder = dataPath;
ctrlDay4Files(2).name = '609015o2_seqday4.plx';
ctrlDay4Files(2).channelNumber = 1;
ctrlDay4Files(2).folder = dataPath;
ctrlDay4Files(3).name = '609015o3_seqday4.plx';
ctrlDay4Files(3).channelNumber = 1;
ctrlDay4Files(3).folder = dataPath;
ctrlDay4Files(4).name = '608948o1_seqday4.plx';
ctrlDay4Files(4).channelNumber = 1;
ctrlDay4Files(4).folder = dataPath;
ctrlDay4Files(5).name = '608948o3_seqday4.plx';
ctrlDay4Files(5).channelNumber = 1;
ctrlDay4Files(5).folder = dataPath;
ctrlDay4Files(6).name = '610422o3_seqday4.plx';
ctrlDay4Files(6).channelNumber = 1;
ctrlDay4Files(6).folder = dataPath;
ctrlDay4Files(7).name = '604147o2_seqday4.plx';
ctrlDay4Files(7).channelNumber = 2;
ctrlDay4Files(7).folder = dataPath;
ctrlDay4Files(8).name = '604193o1_seqday4.plx';
ctrlDay4Files(8).channelNumber = 2;
ctrlDay4Files(8).folder = dataPath;
ctrlDay4Files(9).name = '604193o2_seqday4.plx';
ctrlDay4Files(9).channelNumber = 2;
ctrlDay4Files(9).folder = dataPath;
ctrlDay4Files(10).name = '604193o4_seqday4.plx';
ctrlDay4Files(10).channelNumber = 2;
ctrlDay4Files(10).folder = dataPath;
ctrlDay4Files(11).name = '606213o2_seqday4.plx';
ctrlDay4Files(11).channelNumber = 1;
ctrlDay4Files(11).folder = dataPath;

ctrlDay5Files = struct;
ctrlDay5Files(1).name = '600556o2_seqday5.plx'; 
ctrlDay5Files(1).channelNumber = 1;
ctrlDay5Files(1).folder = dataPath;
ctrlDay5Files(2).name = '609015o2_seqday5.plx';
ctrlDay5Files(2).channelNumber = 1;
ctrlDay5Files(2).folder = dataPath;
ctrlDay5Files(3).name = '609015o3_seqday5.plx';
ctrlDay5Files(3).channelNumber = 1;
ctrlDay5Files(3).folder = dataPath;
ctrlDay5Files(4).name = '608948o1_seqday5.plx';
ctrlDay5Files(4).channelNumber = 1;
ctrlDay5Files(4).folder = dataPath;
ctrlDay5Files(5).name = '608948o3_seqday5.plx';
ctrlDay5Files(5).channelNumber = 1;
ctrlDay5Files(5).folder = dataPath;
ctrlDay5Files(6).name = '610422o3_seqday5.plx';
ctrlDay5Files(6).channelNumber = 1;
ctrlDay5Files(6).folder = dataPath;
ctrlDay5Files(7).name = '604147o2_seqday5.plx';
ctrlDay5Files(7).channelNumber = 2;
ctrlDay5Files(7).folder = dataPath;
ctrlDay5Files(8).name = '604193o1_seqday5.plx';
ctrlDay5Files(8).channelNumber = 2;
ctrlDay5Files(8).folder = dataPath;
ctrlDay5Files(9).name = '604193o2_seqday5.plx';
ctrlDay5Files(9).channelNumber = 2;
ctrlDay5Files(9).folder = dataPath;
ctrlDay5Files(10).name = '604193o4_seqday5.plx';
ctrlDay5Files(10).channelNumber = 2;
ctrlDay5Files(10).folder = dataPath;
ctrlDay5Files(11).name = '606213o2_seqday5.plx';
ctrlDay5Files(11).channelNumber = 1;
ctrlDay5Files(11).folder = dataPath;

expFiles = {expDay1Files,expDay2Files,expDay3Files,expDay4Files,expDay5Files};
ctrlFiles = {ctrlDay1Files,ctrlDay2Files,ctrlDay3Files,ctrlDay4Files,ctrlDay5Files};
clear expDay1Files expDay2Files expDay3Files expDay4Files expDay5Files
clear ctrlDay1Files ctrlDay2Files ctrlDay3Files ctrlDay4Files ctrlDay5Files
