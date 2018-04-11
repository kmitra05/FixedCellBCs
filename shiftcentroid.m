function [xfpdata]= shiftcentroid(dims,xfpdata)
    load shift.mat
    dims=cumsum(dims);
    for i=1:size(xfpdata,2)
        tmp=cell2mat(struct2cell(xfpdata(i).centroid)');
        tmp(:,1)=tmp(:,1)+dims(i,2)+shift(i,2);
        tmp(:,2)=tmp(:,2)+dims(i,1)+shift(i,1);
        xfpdata(i).centroid=tmp;
    end
end