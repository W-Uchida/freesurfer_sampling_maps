#!/bin/bash         
           
fslmaths ./$1/nodes_aseg.nii* -thr 1 -uthr 1 ./$2/Left-Lateral-Ventricle &
fslmaths ./$1/nodes_aseg.nii* -thr 2 -uthr 2 ./$2/Left-Inf-Lat-Vent &
fslmaths ./$1/nodes_aseg.nii* -thr 3 -uthr 3 ./$2/Left-Cerebellum-White-Matter &
fslmaths ./$1/nodes_aseg.nii* -thr 4 -uthr 4 ./$2/Left-Cerebellum-Cortex &
fslmaths ./$1/nodes_aseg.nii* -thr 5 -uthr 5 ./$2/Left-Thalamus-Proper &
fslmaths ./$1/nodes_aseg.nii* -thr 6 -uthr 6 ./$2/Left-Caudate &
fslmaths ./$1/nodes_aseg.nii* -thr 7 -uthr 7 ./$2/Left-Putamen &
fslmaths ./$1/nodes_aseg.nii* -thr 8 -uthr 8 ./$2/Left-Pallidum &
fslmaths ./$1/nodes_aseg.nii* -thr 9 -uthr 9 ./$2/3rd-Ventricle &
fslmaths ./$1/nodes_aseg.nii* -thr 10 -uthr 10 ./$2/4th-Ventricle &
wait           
fslmaths ./$1/nodes_aseg.nii* -thr 11 -uthr 11 ./$2/Brain-Stem &
fslmaths ./$1/nodes_aseg.nii* -thr 12 -uthr 12 ./$2/Left-Hippocampus &
fslmaths ./$1/nodes_aseg.nii* -thr 13 -uthr 13 ./$2/Left-Amygdala &
fslmaths ./$1/nodes_aseg.nii* -thr 14 -uthr 14 ./$2/CSF &
fslmaths ./$1/nodes_aseg.nii* -thr 15 -uthr 15 ./$2/Left-Accumbens-area &
fslmaths ./$1/nodes_aseg.nii* -thr 16 -uthr 16 ./$2/Left-VentralDC &
fslmaths ./$1/nodes_aseg.nii* -thr 17 -uthr 17 ./$2/Left-vessel &
fslmaths ./$1/nodes_aseg.nii* -thr 18 -uthr 18 ./$2/Left-choroid-plexus &
fslmaths ./$1/nodes_aseg.nii* -thr 19 -uthr 19 ./$2/Right-Lateral-Ventricle &
fslmaths ./$1/nodes_aseg.nii* -thr 20 -uthr 20 ./$2/Right-Inf-Lat-Vent &
wait           
fslmaths ./$1/nodes_aseg.nii* -thr 21 -uthr 21 ./$2/Right-Cerebellum-White-Matter &
fslmaths ./$1/nodes_aseg.nii* -thr 22 -uthr 22 ./$2/Right-Cerebellum-Cortex &
fslmaths ./$1/nodes_aseg.nii* -thr 23 -uthr 23 ./$2/Right-Thalamus-Proper &
fslmaths ./$1/nodes_aseg.nii* -thr 24 -uthr 24 ./$2/Right-Caudate &
fslmaths ./$1/nodes_aseg.nii* -thr 25 -uthr 25 ./$2/Right-Putamen &
fslmaths ./$1/nodes_aseg.nii* -thr 26 -uthr 26 ./$2/Right-Pallidum &
fslmaths ./$1/nodes_aseg.nii* -thr 27 -uthr 27 ./$2/Right-Hippocampus &
fslmaths ./$1/nodes_aseg.nii* -thr 28 -uthr 28 ./$2/Right-Amygdala &
fslmaths ./$1/nodes_aseg.nii* -thr 29 -uthr 29 ./$2/Right-Accumbens-area &
fslmaths ./$1/nodes_aseg.nii* -thr 30 -uthr 30 ./$2/Right-VentralDC &
wait           
fslmaths ./$1/nodes_aseg.nii* -thr 31 -uthr 31 ./$2/Right-vessel &
fslmaths ./$1/nodes_aseg.nii* -thr 32 -uthr 32 ./$2/Right-choroid-plexus &
fslmaths ./$1/nodes_aseg.nii* -thr 33 -uthr 33 ./$2/5th-Ventricle &
fslmaths ./$1/nodes_aseg.nii* -thr 34 -uthr 34 ./$2/WM-hypointensities &
fslmaths ./$1/nodes_aseg.nii* -thr 35 -uthr 35 ./$2/Left-WM-hypointensities &
fslmaths ./$1/nodes_aseg.nii* -thr 36 -uthr 36 ./$2/Right-WM-hypointensities &
fslmaths ./$1/nodes_aseg.nii* -thr 37 -uthr 37 ./$2/non-WM-hypointensities &
fslmaths ./$1/nodes_aseg.nii* -thr 38 -uthr 38 ./$2/Left-non-WM-hypointensities &
fslmaths ./$1/nodes_aseg.nii* -thr 39 -uthr 39 ./$2/Right-non-WM-hypointensities &
fslmaths ./$1/nodes_aseg.nii* -thr 40 -uthr 40 ./$2/Optic-Chiasm &
wait           
fslmaths ./$1/nodes_aseg.nii* -thr 41 -uthr 41 ./$2/CC_Posterior &
fslmaths ./$1/nodes_aseg.nii* -thr 42 -uthr 42 ./$2/CC_Mid_Posterior &
fslmaths ./$1/nodes_aseg.nii* -thr 43 -uthr 43 ./$2/CC_Central &
fslmaths ./$1/nodes_aseg.nii* -thr 44 -uthr 44 ./$2/CC_Mid_Anterior &
fslmaths ./$1/nodes_aseg.nii* -thr 45 -uthr 45 ./$2/CC_Anterior &

