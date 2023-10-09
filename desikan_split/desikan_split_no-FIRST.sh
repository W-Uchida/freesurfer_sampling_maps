#!/bin/bash

fslmaths ./$1/nodes_T1.nii* -thr 1 -uthr 1 ./$2/01-lh-bankssts &
fslmaths ./$1/nodes_T1.nii* -thr 2 -uthr 2 ./$2/02-lh-caudalanteriorcingulate &
fslmaths ./$1/nodes_T1.nii* -thr 3 -uthr 3 ./$2/03-lh-caudalmiddlefrontal &
fslmaths ./$1/nodes_T1.nii* -thr 4 -uthr 4 ./$2/04-lh-cuneus &
fslmaths ./$1/nodes_T1.nii* -thr 5 -uthr 5 ./$2/05-lh-entorhinal &
fslmaths ./$1/nodes_T1.nii* -thr 6 -uthr 6 ./$2/06-lh-fusiform &
fslmaths ./$1/nodes_T1.nii* -thr 7 -uthr 7 ./$2/07-lh-inferiorparietal &
fslmaths ./$1/nodes_T1.nii* -thr 8 -uthr 8 ./$2/08-lh-inferiortemporal &
fslmaths ./$1/nodes_T1.nii* -thr 9 -uthr 9 ./$2/09-lh-isthmuscingulate &
fslmaths ./$1/nodes_T1.nii* -thr 10 -uthr 10 ./$2/10-lh-lateraloccipital &
wait
fslmaths ./$1/nodes_T1.nii* -thr 11 -uthr 11 ./$2/11-lh-lateralorbitofrontal &
fslmaths ./$1/nodes_T1.nii* -thr 12 -uthr 12 ./$2/12-lh-lingual &
fslmaths ./$1/nodes_T1.nii* -thr 13 -uthr 13 ./$2/13-lh-medialorbitofrontal &
fslmaths ./$1/nodes_T1.nii* -thr 14 -uthr 14 ./$2/14-lh-middletemporal &
fslmaths ./$1/nodes_T1.nii* -thr 15 -uthr 15 ./$2/15-lh-parahippocampal &
fslmaths ./$1/nodes_T1.nii* -thr 16 -uthr 16 ./$2/16-lh-paracentral &
fslmaths ./$1/nodes_T1.nii* -thr 17 -uthr 17 ./$2/17-lh-parsopercularis &
fslmaths ./$1/nodes_T1.nii* -thr 18 -uthr 18 ./$2/18-lh-parsorbitalis &
fslmaths ./$1/nodes_T1.nii* -thr 19 -uthr 19 ./$2/19-lh-parstriangularis &
fslmaths ./$1/nodes_T1.nii* -thr 20 -uthr 20 ./$2/20-lh-pericalcarine &
wait
fslmaths ./$1/nodes_T1.nii* -thr 21 -uthr 21 ./$2/21-lh-postcentral &
fslmaths ./$1/nodes_T1.nii* -thr 22 -uthr 22 ./$2/22-lh-posteriorcingulate &
fslmaths ./$1/nodes_T1.nii* -thr 23 -uthr 23 ./$2/23-lh-precentral &
fslmaths ./$1/nodes_T1.nii* -thr 24 -uthr 24 ./$2/24-lh-precuneus &
fslmaths ./$1/nodes_T1.nii* -thr 25 -uthr 25 ./$2/25-lh-rostralanteriorcingulate &
fslmaths ./$1/nodes_T1.nii* -thr 26 -uthr 26 ./$2/26-lh-rostralmiddlefrontal &
fslmaths ./$1/nodes_T1.nii* -thr 27 -uthr 27 ./$2/27-lh-superiorfrontal &
fslmaths ./$1/nodes_T1.nii* -thr 28 -uthr 28 ./$2/28-lh-superiorparietal &
fslmaths ./$1/nodes_T1.nii* -thr 29 -uthr 29 ./$2/29-lh-superiortemporal &
fslmaths ./$1/nodes_T1.nii* -thr 30 -uthr 30 ./$2/30-lh-supramarginal &
wait
fslmaths ./$1/nodes_T1.nii* -thr 31 -uthr 31 ./$2/31-lh-frontalpole &
fslmaths ./$1/nodes_T1.nii* -thr 32 -uthr 32 ./$2/32-lh-temporalpole &
fslmaths ./$1/nodes_T1.nii* -thr 33 -uthr 33 ./$2/33-lh-transversetemporal &
fslmaths ./$1/nodes_T1.nii* -thr 34 -uthr 34 ./$2/34-lh-insula &
fslmaths ./$1/nodes_T1.nii* -thr 35 -uthr 35 ./$2/35-Left-Cerebellum-Cortex &
fslmaths ./$1/nodes_T1.nii* -thr 36 -uthr 36 ./$2/36-Left-Thalamus-Proper &
fslmaths ./$1/nodes_T1.nii* -thr 37 -uthr 37 ./$2/37-Left-Caudate &
fslmaths ./$1/nodes_T1.nii* -thr 38 -uthr 38 ./$2/38-Left-Putamen &
fslmaths ./$1/nodes_T1.nii* -thr 39 -uthr 39 ./$2/39-Left-Pallidum &
fslmaths ./$1/nodes_T1.nii* -thr 40 -uthr 40 ./$2/40-Left-Hippocampus &
wait
fslmaths ./$1/nodes_T1.nii* -thr 41 -uthr 41 ./$2/41-Left-Amygdala &
fslmaths ./$1/nodes_T1.nii* -thr 42 -uthr 42 ./$2/42-Left-Accumbens-area &
fslmaths ./$1/nodes_T1.nii* -thr 43 -uthr 43 ./$2/43-Right-Thalamus-Proper &
fslmaths ./$1/nodes_T1.nii* -thr 44 -uthr 44 ./$2/44-Right-Caudate &
fslmaths ./$1/nodes_T1.nii* -thr 45 -uthr 45 ./$2/45-Right-Putamen &
fslmaths ./$1/nodes_T1.nii* -thr 46 -uthr 46 ./$2/46-Right-Pallidum &
fslmaths ./$1/nodes_T1.nii* -thr 47 -uthr 47 ./$2/47-Right-Hippocampus &
fslmaths ./$1/nodes_T1.nii* -thr 48 -uthr 48 ./$2/48-Right-Amygdala &
fslmaths ./$1/nodes_T1.nii* -thr 49 -uthr 49 ./$2/49-Right-Accumbens-area &
fslmaths ./$1/nodes_T1.nii* -thr 50 -uthr 50 ./$2/50-rh-bankssts &
wait
fslmaths ./$1/nodes_T1.nii* -thr 51 -uthr 51 ./$2/51-rh-caudalanteriorcingulate &
fslmaths ./$1/nodes_T1.nii* -thr 52 -uthr 52 ./$2/52-rh-caudalmiddlefrontal &
fslmaths ./$1/nodes_T1.nii* -thr 53 -uthr 53 ./$2/53-rh-cuneus &
fslmaths ./$1/nodes_T1.nii* -thr 54 -uthr 54 ./$2/54-rh-entorhinal &
fslmaths ./$1/nodes_T1.nii* -thr 55 -uthr 55 ./$2/55-rh-fusiform &
fslmaths ./$1/nodes_T1.nii* -thr 56 -uthr 56 ./$2/56-rh-inferiorparietal &
fslmaths ./$1/nodes_T1.nii* -thr 57 -uthr 57 ./$2/57-rh-inferiortemporal &
fslmaths ./$1/nodes_T1.nii* -thr 58 -uthr 58 ./$2/58-rh-isthmuscingulate &
fslmaths ./$1/nodes_T1.nii* -thr 59 -uthr 59 ./$2/59-rh-lateraloccipital &
fslmaths ./$1/nodes_T1.nii* -thr 60 -uthr 60 ./$2/60-rh-lateralorbitofrontal &
wait
fslmaths ./$1/nodes_T1.nii* -thr 61 -uthr 61 ./$2/61-rh-lingual &
fslmaths ./$1/nodes_T1.nii* -thr 62 -uthr 62 ./$2/62-rh-medialorbitofrontal &
fslmaths ./$1/nodes_T1.nii* -thr 63 -uthr 63 ./$2/63-rh-middletemporal &
fslmaths ./$1/nodes_T1.nii* -thr 64 -uthr 64 ./$2/64-rh-parahippocampal &
fslmaths ./$1/nodes_T1.nii* -thr 65 -uthr 65 ./$2/65-rh-paracentral &
fslmaths ./$1/nodes_T1.nii* -thr 66 -uthr 66 ./$2/66-rh-parsopercularis &
fslmaths ./$1/nodes_T1.nii* -thr 67 -uthr 67 ./$2/67-rh-parsorbitalis &
fslmaths ./$1/nodes_T1.nii* -thr 68 -uthr 68 ./$2/68-rh-parstriangularis &
fslmaths ./$1/nodes_T1.nii* -thr 69 -uthr 69 ./$2/69-rh-pericalcarine &
fslmaths ./$1/nodes_T1.nii* -thr 70 -uthr 70 ./$2/70-rh-postcentral &
wait
fslmaths ./$1/nodes_T1.nii* -thr 71 -uthr 71 ./$2/71-rh-posteriorcingulate &
fslmaths ./$1/nodes_T1.nii* -thr 72 -uthr 72 ./$2/72-rh-precentral &
fslmaths ./$1/nodes_T1.nii* -thr 73 -uthr 73 ./$2/73-rh-precuneus &
fslmaths ./$1/nodes_T1.nii* -thr 74 -uthr 74 ./$2/74-rh-rostralanteriorcingulate &
fslmaths ./$1/nodes_T1.nii* -thr 75 -uthr 75 ./$2/75-rh-rostralmiddlefrontal &
fslmaths ./$1/nodes_T1.nii* -thr 76 -uthr 76 ./$2/76-rh-superiorfrontal &
fslmaths ./$1/nodes_T1.nii* -thr 77 -uthr 77 ./$2/77-rh-superiorparietal &
fslmaths ./$1/nodes_T1.nii* -thr 78 -uthr 78 ./$2/78-rh-superiortemporal &
fslmaths ./$1/nodes_T1.nii* -thr 79 -uthr 79 ./$2/79-rh-supramarginal &
fslmaths ./$1/nodes_T1.nii* -thr 80 -uthr 80 ./$2/80-rh-frontalpole &
wait
fslmaths ./$1/nodes_T1.nii* -thr 81 -uthr 81 ./$2/81-rh-temporalpole &
fslmaths ./$1/nodes_T1.nii* -thr 82 -uthr 82 ./$2/82-rh-transversetemporal &
fslmaths ./$1/nodes_T1.nii* -thr 83 -uthr 83 ./$2/83-rh-insula &
fslmaths ./$1/nodes_T1.nii* -thr 84 -uthr 84 ./$2/84-Right-Cerebellum-Cortex &
