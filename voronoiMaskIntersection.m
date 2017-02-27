function [new_mask] = voronoiMaskIntersection (voronoi_mask, combined_mask)
    cut_mask = combined_mask - (voronoi_mask == 0 & combined_mask ~= 0);
    cut_mask = bwareaopen(cut_mask, 1000);
    %imshow(cut_mask);
    se = strel('disk', 7);
    dilate_mask = imdilate(cut_mask, se);
    new_mask = dilate_mask - (voronoi_mask == 0 & dilate_mask ~= 0);
    new_mask = bwareaopen(new_mask, 1000);
    %imshow(new_mask);
    %Test sequence to make sure the number of cells countedin new_mask is
    %consistent with the numberof voronoi polygons.
    cc1 = bwconncomp(new_mask);
    cc2 = bwconncomp(voronoi_mask);
    stats1 = regionprops(cc1, 'Area');
    stats2 = regionprops(cc2, 'Area');
    if length([stats1.Area]) ~= length([stats2.Area])
        disp('Error: The mask generated by the function voronoiMaskIntersection does not contain the same number of cells as voronoi polygons.');
        if length([stats1.Area]) < length([stats2.Area])
            disp('The number of cells is less than the number of voronoi polygons.');
        else
            disp('The number of cells is greater than the number of voronoi polygons.');
        end
    end
end