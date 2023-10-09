#!/bin/bash        
          
fslmaths ./$1/nodes_wmparc.nii* -thr 1 -uthr 1 ./$2/wm-lh-unknown
fslmaths ./$1/nodes_wmparc.nii* -thr 2 -uthr 2 ./$2/wm-lh-bankssts
fslmaths ./$1/nodes_wmparc.nii* -thr 3 -uthr 3 ./$2/wm-lh-caudalanteriorcingulate
fslmaths ./$1/nodes_wmparc.nii* -thr 4 -uthr 4 ./$2/wm-lh-caudalmiddlefrontal
fslmaths ./$1/nodes_wmparc.nii* -thr 5 -uthr 5 ./$2/wm-lh-corpuscallosum
fslmaths ./$1/nodes_wmparc.nii* -thr 6 -uthr 6 ./$2/wm-lh-cuneus
fslmaths ./$1/nodes_wmparc.nii* -thr 7 -uthr 7 ./$2/wm-lh-entorhinal
fslmaths ./$1/nodes_wmparc.nii* -thr 8 -uthr 8 ./$2/wm-lh-fusiform
fslmaths ./$1/nodes_wmparc.nii* -thr 9 -uthr 9 ./$2/wm-lh-inferiorparietal
fslmaths ./$1/nodes_wmparc.nii* -thr 10 -uthr 10 ./$2/wm-lh-inferiortemporal
wait          
fslmaths ./$1/nodes_wmparc.nii* -thr 11 -uthr 11 ./$2/wm-lh-isthmuscingulate
fslmaths ./$1/nodes_wmparc.nii* -thr 12 -uthr 12 ./$2/wm-lh-lateraloccipital
fslmaths ./$1/nodes_wmparc.nii* -thr 13 -uthr 13 ./$2/wm-lh-lateralorbitofrontal
fslmaths ./$1/nodes_wmparc.nii* -thr 14 -uthr 14 ./$2/wm-lh-lingual
fslmaths ./$1/nodes_wmparc.nii* -thr 15 -uthr 15 ./$2/wm-lh-medialorbitofrontal
fslmaths ./$1/nodes_wmparc.nii* -thr 16 -uthr 16 ./$2/wm-lh-middletemporal
fslmaths ./$1/nodes_wmparc.nii* -thr 17 -uthr 17 ./$2/wm-lh-parahippocampal
fslmaths ./$1/nodes_wmparc.nii* -thr 18 -uthr 18 ./$2/wm-lh-paracentral
fslmaths ./$1/nodes_wmparc.nii* -thr 19 -uthr 19 ./$2/wm-lh-parsopercularis
fslmaths ./$1/nodes_wmparc.nii* -thr 20 -uthr 20 ./$2/wm-lh-parsorbitalis
wait          
fslmaths ./$1/nodes_wmparc.nii* -thr 21 -uthr 21 ./$2/wm-lh-parstriangularis
fslmaths ./$1/nodes_wmparc.nii* -thr 22 -uthr 22 ./$2/wm-lh-pericalcarine
fslmaths ./$1/nodes_wmparc.nii* -thr 23 -uthr 23 ./$2/wm-lh-postcentral
fslmaths ./$1/nodes_wmparc.nii* -thr 24 -uthr 24 ./$2/wm-lh-posteriorcingulate
fslmaths ./$1/nodes_wmparc.nii* -thr 25 -uthr 25 ./$2/wm-lh-precentral
fslmaths ./$1/nodes_wmparc.nii* -thr 26 -uthr 26 ./$2/wm-lh-precuneus
fslmaths ./$1/nodes_wmparc.nii* -thr 27 -uthr 27 ./$2/wm-lh-rostralanteriorcingulate
fslmaths ./$1/nodes_wmparc.nii* -thr 28 -uthr 28 ./$2/wm-lh-rostralmiddlefrontal
fslmaths ./$1/nodes_wmparc.nii* -thr 29 -uthr 29 ./$2/wm-lh-superiorfrontal
fslmaths ./$1/nodes_wmparc.nii* -thr 30 -uthr 30 ./$2/wm-lh-superiorparietal
wait          
fslmaths ./$1/nodes_wmparc.nii* -thr 31 -uthr 31 ./$2/wm-lh-superiortemporal
fslmaths ./$1/nodes_wmparc.nii* -thr 32 -uthr 32 ./$2/wm-lh-supramarginal
fslmaths ./$1/nodes_wmparc.nii* -thr 33 -uthr 33 ./$2/wm-lh-frontalpole
fslmaths ./$1/nodes_wmparc.nii* -thr 34 -uthr 34 ./$2/wm-lh-temporalpole
fslmaths ./$1/nodes_wmparc.nii* -thr 35 -uthr 35 ./$2/wm-lh-transversetemporal
fslmaths ./$1/nodes_wmparc.nii* -thr 36 -uthr 36 ./$2/wm-lh-insula
fslmaths ./$1/nodes_wmparc.nii* -thr 37 -uthr 37 ./$2/wm-rh-unknown
fslmaths ./$1/nodes_wmparc.nii* -thr 38 -uthr 38 ./$2/wm-rh-bankssts
fslmaths ./$1/nodes_wmparc.nii* -thr 39 -uthr 39 ./$2/wm-rh-caudalanteriorcingulate
fslmaths ./$1/nodes_wmparc.nii* -thr 40 -uthr 40 ./$2/wm-rh-caudalmiddlefrontal
wait          
fslmaths ./$1/nodes_wmparc.nii* -thr 41 -uthr 41 ./$2/wm-rh-corpuscallosum
fslmaths ./$1/nodes_wmparc.nii* -thr 42 -uthr 42 ./$2/wm-rh-cuneus
fslmaths ./$1/nodes_wmparc.nii* -thr 43 -uthr 43 ./$2/wm-rh-entorhinal
fslmaths ./$1/nodes_wmparc.nii* -thr 44 -uthr 44 ./$2/wm-rh-fusiform
fslmaths ./$1/nodes_wmparc.nii* -thr 45 -uthr 45 ./$2/wm-rh-inferiorparietal
fslmaths ./$1/nodes_wmparc.nii* -thr 46 -uthr 46 ./$2/wm-rh-inferiortemporal
fslmaths ./$1/nodes_wmparc.nii* -thr 47 -uthr 47 ./$2/wm-rh-isthmuscingulate
fslmaths ./$1/nodes_wmparc.nii* -thr 48 -uthr 48 ./$2/wm-rh-lateraloccipital
fslmaths ./$1/nodes_wmparc.nii* -thr 49 -uthr 49 ./$2/wm-rh-lateralorbitofrontal
fslmaths ./$1/nodes_wmparc.nii* -thr 50 -uthr 50 ./$2/wm-rh-lingual
wait          
fslmaths ./$1/nodes_wmparc.nii* -thr 51 -uthr 51 ./$2/wm-rh-medialorbitofrontal
fslmaths ./$1/nodes_wmparc.nii* -thr 52 -uthr 52 ./$2/wm-rh-middletemporal
fslmaths ./$1/nodes_wmparc.nii* -thr 53 -uthr 53 ./$2/wm-rh-parahippocampal
fslmaths ./$1/nodes_wmparc.nii* -thr 54 -uthr 54 ./$2/wm-rh-paracentral
fslmaths ./$1/nodes_wmparc.nii* -thr 55 -uthr 55 ./$2/wm-rh-parsopercularis
fslmaths ./$1/nodes_wmparc.nii* -thr 56 -uthr 56 ./$2/wm-rh-parsorbitalis
fslmaths ./$1/nodes_wmparc.nii* -thr 57 -uthr 57 ./$2/wm-rh-parstriangularis
fslmaths ./$1/nodes_wmparc.nii* -thr 58 -uthr 58 ./$2/wm-rh-pericalcarine
fslmaths ./$1/nodes_wmparc.nii* -thr 59 -uthr 59 ./$2/wm-rh-postcentral
fslmaths ./$1/nodes_wmparc.nii* -thr 60 -uthr 60 ./$2/wm-rh-posteriorcingulate
wait          
fslmaths ./$1/nodes_wmparc.nii* -thr 61 -uthr 61 ./$2/wm-rh-precentral
fslmaths ./$1/nodes_wmparc.nii* -thr 62 -uthr 62 ./$2/wm-rh-precuneus
fslmaths ./$1/nodes_wmparc.nii* -thr 63 -uthr 63 ./$2/wm-rh-rostralanteriorcingulate
fslmaths ./$1/nodes_wmparc.nii* -thr 64 -uthr 64 ./$2/wm-rh-rostralmiddlefrontal
fslmaths ./$1/nodes_wmparc.nii* -thr 65 -uthr 65 ./$2/wm-rh-superiorfrontal
fslmaths ./$1/nodes_wmparc.nii* -thr 66 -uthr 66 ./$2/wm-rh-superiorparietal
fslmaths ./$1/nodes_wmparc.nii* -thr 67 -uthr 67 ./$2/wm-rh-superiortemporal
fslmaths ./$1/nodes_wmparc.nii* -thr 68 -uthr 68 ./$2/wm-rh-supramarginal
fslmaths ./$1/nodes_wmparc.nii* -thr 69 -uthr 69 ./$2/wm-rh-frontalpole
fslmaths ./$1/nodes_wmparc.nii* -thr 70 -uthr 70 ./$2/wm-rh-temporalpole
wait          
fslmaths ./$1/nodes_wmparc.nii* -thr 71 -uthr 71 ./$2/wm-rh-transversetemporal
fslmaths ./$1/nodes_wmparc.nii* -thr 72 -uthr 72 ./$2/wm-rh-insula

