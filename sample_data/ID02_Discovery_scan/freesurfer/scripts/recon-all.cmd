\n\n#---------------------------------
# New invocation of recon-all Mon Oct  9 15:37:50 JST 2023 
\n mri_convert /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/T1WI.nii.gz /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/orig/001.mgz \n
#--------------------------------------------
#@# MotionCor Mon Oct  9 15:38:10 JST 2023
\n cp /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/orig/001.mgz /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/rawavg.mgz \n
\n mri_convert /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/rawavg.mgz /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/orig.mgz --conform \n
\n mri_add_xform_to_header -c /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/transforms/talairach.xfm /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/orig.mgz /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/orig.mgz \n
#--------------------------------------------
#@# Talairach Mon Oct  9 15:38:17 JST 2023
\n mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --ants-n4 --n 1 --proto-iters 1000 --distance 50 \n
\n talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm \n
talairach_avi log file is transforms/talairach_avi.log...
\n cp transforms/talairach.auto.xfm transforms/talairach.xfm \n
lta_convert --src orig.mgz --trg /Users/uchidawataru/bin/freesurfer/average/mni305.cor.mgz --inxfm transforms/talairach.xfm --outlta transforms/talairach.xfm.lta --subject fsaverage --ltavox2vox
#--------------------------------------------
#@# Talairach Failure Detection Mon Oct  9 15:40:34 JST 2023
\n talairach_afd -T 0.005 -xfm transforms/talairach.xfm \n
\n awk -f /Users/uchidawataru/bin/freesurfer/bin/extract_talairach_avi_QA.awk /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/transforms/talairach_avi.log \n
\n tal_QC_AZS /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/transforms/talairach_avi.log \n
#--------------------------------------------
#@# Nu Intensity Correction Mon Oct  9 15:40:34 JST 2023
\n mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 --ants-n4 \n
\n mri_add_xform_to_header -c /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/transforms/talairach.xfm nu.mgz nu.mgz \n
#--------------------------------------------
#@# Intensity Normalization Mon Oct  9 15:42:41 JST 2023
\n mri_normalize -g 1 -seed 1234 -mprage nu.mgz T1.mgz \n
#--------------------------------------------
#@# Skull Stripping Mon Oct  9 15:44:03 JST 2023
\n mri_em_register -skull nu.mgz /Users/uchidawataru/bin/freesurfer/average/RB_all_withskull_2020_01_02.gca transforms/talairach_with_skull.lta \n
\n mri_watershed -T1 -brain_atlas /Users/uchidawataru/bin/freesurfer/average/RB_all_withskull_2020_01_02.gca transforms/talairach_with_skull.lta T1.mgz brainmask.auto.mgz \n
\n cp brainmask.auto.mgz brainmask.mgz \n
#-------------------------------------
#@# EM Registration Mon Oct  9 15:58:57 JST 2023
\n mri_em_register -uns 3 -mask brainmask.mgz nu.mgz /Users/uchidawataru/bin/freesurfer/average/RB_all_2020-01-02.gca transforms/talairach.lta \n
#--------------------------------------
#@# CA Normalize Mon Oct  9 16:09:17 JST 2023
\n mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz nu.mgz /Users/uchidawataru/bin/freesurfer/average/RB_all_2020-01-02.gca transforms/talairach.lta norm.mgz \n
#--------------------------------------
#@# CA Reg Mon Oct  9 16:10:03 JST 2023
\n mri_ca_register -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /Users/uchidawataru/bin/freesurfer/average/RB_all_2020-01-02.gca transforms/talairach.m3z \n
#--------------------------------------
#@# SubCort Seg Mon Oct  9 18:24:37 JST 2023
\n mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /Users/uchidawataru/bin/freesurfer/average/RB_all_2020-01-02.gca aseg.auto_noCCseg.mgz \n
#--------------------------------------
#@# CC Seg Mon Oct  9 18:56:19 JST 2023
\n mri_cc -aseg aseg.auto_noCCseg.mgz -o aseg.auto.mgz -lta /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/transforms/cc_up.lta freesurfer \n
#--------------------------------------
#@# Merge ASeg Mon Oct  9 18:56:45 JST 2023
\n cp aseg.auto.mgz aseg.presurf.mgz \n
#--------------------------------------------
#@# Intensity Normalization2 Mon Oct  9 18:56:45 JST 2023
\n mri_normalize -seed 1234 -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz \n
#--------------------------------------------
#@# Mask BFS Mon Oct  9 18:58:48 JST 2023
\n mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz \n
#--------------------------------------------
#@# WM Segmentation Mon Oct  9 18:58:50 JST 2023
\n AntsDenoiseImageFs -i brain.mgz -o antsdn.brain.mgz \n
\n mri_segment -wsizemm 13 -mprage antsdn.brain.mgz wm.seg.mgz \n
\n mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz \n
\n mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz \n
#--------------------------------------------
#@# Fill Mon Oct  9 19:00:46 JST 2023
\n mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.presurf.mgz wm.mgz filled.mgz \n
#--------------------------------------------
#@# Tessellate lh Mon Oct  9 19:01:53 JST 2023
\n mri_pretess ../mri/filled.mgz 255 ../mri/norm.mgz ../mri/filled-pretess255.mgz \n
\n mri_tessellate ../mri/filled-pretess255.mgz 255 ../surf/lh.orig.nofix \n
\n rm -f ../mri/filled-pretess255.mgz \n
\n mris_extract_main_component ../surf/lh.orig.nofix ../surf/lh.orig.nofix \n
#--------------------------------------------
#@# Tessellate rh Mon Oct  9 19:01:56 JST 2023
\n mri_pretess ../mri/filled.mgz 127 ../mri/norm.mgz ../mri/filled-pretess127.mgz \n
\n mri_tessellate ../mri/filled-pretess127.mgz 127 ../surf/rh.orig.nofix \n
\n rm -f ../mri/filled-pretess127.mgz \n
\n mris_extract_main_component ../surf/rh.orig.nofix ../surf/rh.orig.nofix \n
#--------------------------------------------
#@# Smooth1 lh Mon Oct  9 19:02:00 JST 2023
\n mris_smooth -nw -seed 1234 ../surf/lh.orig.nofix ../surf/lh.smoothwm.nofix \n
#--------------------------------------------
#@# Smooth1 rh Mon Oct  9 19:02:03 JST 2023
\n mris_smooth -nw -seed 1234 ../surf/rh.orig.nofix ../surf/rh.smoothwm.nofix \n
#--------------------------------------------
#@# Inflation1 lh Mon Oct  9 19:02:06 JST 2023
\n mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix \n
#--------------------------------------------
#@# Inflation1 rh Mon Oct  9 19:02:20 JST 2023
\n mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix \n
#--------------------------------------------
#@# QSphere lh Mon Oct  9 19:02:35 JST 2023
\n mris_sphere -q -p 6 -a 128 -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix \n
#--------------------------------------------
#@# QSphere rh Mon Oct  9 19:04:19 JST 2023
\n mris_sphere -q -p 6 -a 128 -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix \n
#@# Fix Topology lh Mon Oct  9 19:05:51 JST 2023
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 freesurfer lh \n
#@# Fix Topology rh Mon Oct  9 19:07:55 JST 2023
\n mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 freesurfer rh \n
\n mris_euler_number ../surf/lh.orig.premesh \n
\n mris_euler_number ../surf/rh.orig.premesh \n
\n mris_remesh --remesh --iters 3 --input /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.orig.premesh --output /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.orig \n
\n mris_remesh --remesh --iters 3 --input /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.orig.premesh --output /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.orig \n
\n mris_remove_intersection ../surf/lh.orig ../surf/lh.orig \n
\n rm ../surf/lh.inflated \n
\n mris_remove_intersection ../surf/rh.orig ../surf/rh.orig \n
\n rm ../surf/rh.inflated \n
#--------------------------------------------
#@# AutoDetGWStats lh Mon Oct  9 19:11:02 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.lh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/lh.orig.premesh
#--------------------------------------------
#@# AutoDetGWStats rh Mon Oct  9 19:11:05 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.rh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/rh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc lh Mon Oct  9 19:11:09 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --wm wm.mgz --threads 1 --invol brain.finalsurfs.mgz --lh --i ../surf/lh.orig --o ../surf/lh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
#--------------------------------------------
#@# WhitePreAparc rh Mon Oct  9 19:15:36 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --wm wm.mgz --threads 1 --invol brain.finalsurfs.mgz --rh --i ../surf/rh.orig --o ../surf/rh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
#--------------------------------------------
#@# CortexLabel lh Mon Oct  9 19:20:06 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 0 ../label/lh.cortex.label
#--------------------------------------------
#@# CortexLabel+HipAmyg lh Mon Oct  9 19:20:25 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 1 ../label/lh.cortex+hipamyg.label
#--------------------------------------------
#@# CortexLabel rh Mon Oct  9 19:20:44 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 0 ../label/rh.cortex.label
#--------------------------------------------
#@# CortexLabel+HipAmyg rh Mon Oct  9 19:21:03 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mri_label2label --label-cortex ../surf/rh.white.preaparc aseg.presurf.mgz 1 ../label/rh.cortex+hipamyg.label
#--------------------------------------------
#@# Smooth2 lh Mon Oct  9 19:21:22 JST 2023
\n mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm \n
#--------------------------------------------
#@# Smooth2 rh Mon Oct  9 19:21:25 JST 2023
\n mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm \n
#--------------------------------------------
#@# Inflation2 lh Mon Oct  9 19:21:29 JST 2023
\n mris_inflate ../surf/lh.smoothwm ../surf/lh.inflated \n
#--------------------------------------------
#@# Inflation2 rh Mon Oct  9 19:21:47 JST 2023
\n mris_inflate ../surf/rh.smoothwm ../surf/rh.inflated \n
#--------------------------------------------
#@# Curv .H and .K lh Mon Oct  9 19:22:07 JST 2023
\n mris_curvature -w -seed 1234 lh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated \n
#--------------------------------------------
#@# Curv .H and .K rh Mon Oct  9 19:22:54 JST 2023
\n mris_curvature -w -seed 1234 rh.white.preaparc \n
\n mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated \n
#--------------------------------------------
#@# Sphere lh Mon Oct  9 19:23:42 JST 2023
\n mris_sphere -seed 1234 ../surf/lh.inflated ../surf/lh.sphere \n
#--------------------------------------------
#@# Sphere rh Mon Oct  9 19:33:51 JST 2023
\n mris_sphere -seed 1234 ../surf/rh.inflated ../surf/rh.sphere \n
#--------------------------------------------
#@# Surf Reg lh Mon Oct  9 19:44:14 JST 2023
\n mris_register -curv ../surf/lh.sphere /Users/uchidawataru/bin/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/lh.sphere.reg \n
\n ln -sf lh.sphere.reg lh.fsaverage.sphere.reg \n
#--------------------------------------------
#@# Surf Reg rh Mon Oct  9 19:50:59 JST 2023
\n mris_register -curv ../surf/rh.sphere /Users/uchidawataru/bin/freesurfer/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/rh.sphere.reg \n
\n ln -sf rh.sphere.reg rh.fsaverage.sphere.reg \n
#--------------------------------------------
#@# Jacobian white lh Mon Oct  9 19:57:14 JST 2023
\n mris_jacobian ../surf/lh.white.preaparc ../surf/lh.sphere.reg ../surf/lh.jacobian_white \n
#--------------------------------------------
#@# Jacobian white rh Mon Oct  9 19:57:15 JST 2023
\n mris_jacobian ../surf/rh.white.preaparc ../surf/rh.sphere.reg ../surf/rh.jacobian_white \n
#--------------------------------------------
#@# AvgCurv lh Mon Oct  9 19:57:16 JST 2023
\n mrisp_paint -a 5 /Users/uchidawataru/bin/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/lh.sphere.reg ../surf/lh.avg_curv \n
#--------------------------------------------
#@# AvgCurv rh Mon Oct  9 19:57:17 JST 2023
\n mrisp_paint -a 5 /Users/uchidawataru/bin/freesurfer/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/rh.sphere.reg ../surf/rh.avg_curv \n
#-----------------------------------------
#@# Cortical Parc lh Mon Oct  9 19:57:18 JST 2023
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 freesurfer lh ../surf/lh.sphere.reg /Users/uchidawataru/bin/freesurfer/average/lh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.annot \n
#-----------------------------------------
#@# Cortical Parc rh Mon Oct  9 19:57:31 JST 2023
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 freesurfer rh ../surf/rh.sphere.reg /Users/uchidawataru/bin/freesurfer/average/rh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.annot \n
#--------------------------------------------
#@# WhiteSurfs lh Mon Oct  9 19:57:43 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --seg aseg.presurf.mgz --threads 1 --wm wm.mgz --invol brain.finalsurfs.mgz --lh --i ../surf/lh.white.preaparc --o ../surf/lh.white --white --nsmooth 0 --rip-label ../label/lh.cortex.label --rip-bg --rip-surf ../surf/lh.white.preaparc --aparc ../label/lh.aparc.annot
#--------------------------------------------
#@# WhiteSurfs rh Mon Oct  9 20:01:25 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --seg aseg.presurf.mgz --threads 1 --wm wm.mgz --invol brain.finalsurfs.mgz --rh --i ../surf/rh.white.preaparc --o ../surf/rh.white --white --nsmooth 0 --rip-label ../label/rh.cortex.label --rip-bg --rip-surf ../surf/rh.white.preaparc --aparc ../label/rh.aparc.annot
#--------------------------------------------
#@# T1PialSurf lh Mon Oct  9 20:05:15 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --seg aseg.presurf.mgz --threads 1 --wm wm.mgz --invol brain.finalsurfs.mgz --lh --i ../surf/lh.white --o ../surf/lh.pial.T1 --pial --nsmooth 0 --rip-label ../label/lh.cortex+hipamyg.label --pin-medial-wall ../label/lh.cortex.label --aparc ../label/lh.aparc.annot --repulse-surf ../surf/lh.white --white-surf ../surf/lh.white
#--------------------------------------------
#@# T1PialSurf rh Mon Oct  9 20:09:59 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.rh.dat --seg aseg.presurf.mgz --threads 1 --wm wm.mgz --invol brain.finalsurfs.mgz --rh --i ../surf/rh.white --o ../surf/rh.pial.T1 --pial --nsmooth 0 --rip-label ../label/rh.cortex+hipamyg.label --pin-medial-wall ../label/rh.cortex.label --aparc ../label/rh.aparc.annot --repulse-surf ../surf/rh.white --white-surf ../surf/rh.white
#@# white curv lh Mon Oct  9 20:16:11 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
#@# white area lh Mon Oct  9 20:16:13 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
#@# pial curv lh Mon Oct  9 20:16:14 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
#@# pial area lh Mon Oct  9 20:16:17 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
#@# thickness lh Mon Oct  9 20:16:18 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
#@# area and vertex vol lh Mon Oct  9 20:16:57 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
#@# white curv rh Mon Oct  9 20:16:59 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --curv-map ../surf/rh.white 2 10 ../surf/rh.curv
#@# white area rh Mon Oct  9 20:17:02 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --area-map ../surf/rh.white ../surf/rh.area
#@# pial curv rh Mon Oct  9 20:17:03 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --curv-map ../surf/rh.pial 2 10 ../surf/rh.curv.pial
#@# pial area rh Mon Oct  9 20:17:06 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --area-map ../surf/rh.pial ../surf/rh.area.pial
#@# thickness rh Mon Oct  9 20:17:07 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
#@# area and vertex vol rh Mon Oct  9 20:17:50 JST 2023
cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri
mris_place_surface --thickness ../surf/rh.white ../surf/rh.pial 20 5 ../surf/rh.thickness
\n#-----------------------------------------
#@# Curvature Stats lh Mon Oct  9 20:17:52 JST 2023
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm freesurfer lh curv sulc \n
\n#-----------------------------------------
#@# Curvature Stats rh Mon Oct  9 20:17:56 JST 2023
\n mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm freesurfer rh curv sulc \n
#--------------------------------------------
#@# Cortical ribbon mask Mon Oct  9 20:18:00 JST 2023
\n mris_volmask --aseg_name aseg.presurf --label_left_white 2 --label_left_ribbon 3 --label_right_white 41 --label_right_ribbon 42 --save_ribbon freesurfer \n
#-----------------------------------------
#@# Cortical Parc 2 lh Mon Oct  9 20:32:30 JST 2023
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 freesurfer lh ../surf/lh.sphere.reg /Users/uchidawataru/bin/freesurfer/average/lh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.a2009s.annot \n
#-----------------------------------------
#@# Cortical Parc 2 rh Mon Oct  9 20:32:48 JST 2023
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 freesurfer rh ../surf/rh.sphere.reg /Users/uchidawataru/bin/freesurfer/average/rh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.a2009s.annot \n
#-----------------------------------------
#@# Cortical Parc 3 lh Mon Oct  9 20:33:06 JST 2023
\n mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 freesurfer lh ../surf/lh.sphere.reg /Users/uchidawataru/bin/freesurfer/average/lh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.DKTatlas.annot \n
#-----------------------------------------
#@# Cortical Parc 3 rh Mon Oct  9 20:33:19 JST 2023
\n mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 freesurfer rh ../surf/rh.sphere.reg /Users/uchidawataru/bin/freesurfer/average/rh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.DKTatlas.annot \n
#-----------------------------------------
#@# WM/GM Contrast lh Mon Oct  9 20:33:32 JST 2023
\n pctsurfcon --s freesurfer --lh-only \n
#-----------------------------------------
#@# WM/GM Contrast rh Mon Oct  9 20:33:36 JST 2023
\n pctsurfcon --s freesurfer --rh-only \n
#-----------------------------------------
#@# Relabel Hypointensities Mon Oct  9 20:33:40 JST 2023
\n mri_relabel_hypointensities aseg.presurf.mgz ../surf aseg.presurf.hypos.mgz \n
#-----------------------------------------
#@# APas-to-ASeg Mon Oct  9 20:33:59 JST 2023
\n mri_surf2volseg --o aseg.mgz --i aseg.presurf.hypos.mgz --fix-presurf-with-ribbon /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/mri/ribbon.mgz --threads 1 --lh-cortex-mask /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/lh.cortex.label --lh-white /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.white --lh-pial /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.pial --rh-cortex-mask /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/rh.cortex.label --rh-white /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.white --rh-pial /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.pial \n
\n mri_brainvol_stats freesurfer \n
#-----------------------------------------
#@# AParc-to-ASeg aparc Mon Oct  9 20:34:20 JST 2023
\n mri_surf2volseg --o aparc+aseg.mgz --label-cortex --i aseg.mgz --threads 1 --lh-annot /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/lh.aparc.annot 1000 --lh-cortex-mask /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/lh.cortex.label --lh-white /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.white --lh-pial /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.pial --rh-annot /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/rh.aparc.annot 2000 --rh-cortex-mask /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/rh.cortex.label --rh-white /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.white --rh-pial /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.pial \n
#-----------------------------------------
#@# AParc-to-ASeg aparc.a2009s Mon Oct  9 20:37:45 JST 2023
\n mri_surf2volseg --o aparc.a2009s+aseg.mgz --label-cortex --i aseg.mgz --threads 1 --lh-annot /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/lh.aparc.a2009s.annot 11100 --lh-cortex-mask /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/lh.cortex.label --lh-white /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.white --lh-pial /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.pial --rh-annot /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/rh.aparc.a2009s.annot 12100 --rh-cortex-mask /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/rh.cortex.label --rh-white /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.white --rh-pial /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.pial \n
#-----------------------------------------
#@# AParc-to-ASeg aparc.DKTatlas Mon Oct  9 20:41:17 JST 2023
\n mri_surf2volseg --o aparc.DKTatlas+aseg.mgz --label-cortex --i aseg.mgz --threads 1 --lh-annot /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/lh.aparc.DKTatlas.annot 1000 --lh-cortex-mask /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/lh.cortex.label --lh-white /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.white --lh-pial /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.pial --rh-annot /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/rh.aparc.DKTatlas.annot 2000 --rh-cortex-mask /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/rh.cortex.label --rh-white /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.white --rh-pial /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.pial \n
#-----------------------------------------
#@# WMParc Mon Oct  9 20:44:18 JST 2023
\n mri_surf2volseg --o wmparc.mgz --label-wm --i aparc+aseg.mgz --threads 1 --lh-annot /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/lh.aparc.annot 3000 --lh-cortex-mask /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/lh.cortex.label --lh-white /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.white --lh-pial /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/lh.pial --rh-annot /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/rh.aparc.annot 4000 --rh-cortex-mask /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/label/rh.cortex.label --rh-white /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.white --rh-pial /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/freesurfer/surf/rh.pial \n
\n mri_segstats --seed 1234 --seg mri/wmparc.mgz --sum stats/wmparc.stats --pv mri/norm.mgz --excludeid 0 --brainmask mri/brainmask.mgz --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --subject freesurfer --surf-wm-vol --ctab /Users/uchidawataru/bin/freesurfer/WMParcStatsLUT.txt --etiv \n
#-----------------------------------------
#@# Parcellation Stats lh Mon Oct  9 20:49:46 JST 2023
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab freesurfer lh white \n
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.pial.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab freesurfer lh pial \n
#-----------------------------------------
#@# Parcellation Stats rh Mon Oct  9 20:50:06 JST 2023
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab freesurfer rh white \n
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.pial.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab freesurfer rh pial \n
#-----------------------------------------
#@# Parcellation Stats 2 lh Mon Oct  9 20:50:27 JST 2023
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.a2009s.stats -b -a ../label/lh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab freesurfer lh white \n
#-----------------------------------------
#@# Parcellation Stats 2 rh Mon Oct  9 20:50:38 JST 2023
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.a2009s.stats -b -a ../label/rh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab freesurfer rh white \n
#-----------------------------------------
#@# Parcellation Stats 3 lh Mon Oct  9 20:50:51 JST 2023
\n mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.DKTatlas.stats -b -a ../label/lh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab freesurfer lh white \n
#-----------------------------------------
#@# Parcellation Stats 3 rh Mon Oct  9 20:51:03 JST 2023
\n mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.DKTatlas.stats -b -a ../label/rh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab freesurfer rh white \n
#--------------------------------------------
#@# ASeg Stats Mon Oct  9 20:51:15 JST 2023
\n mri_segstats --seed 1234 --seg mri/aseg.mgz --sum stats/aseg.stats --pv mri/norm.mgz --empty --brainmask mri/brainmask.mgz --brain-vol-from-seg --excludeid 0 --excl-ctxgmwm --supratent --subcortgray --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --etiv --surf-wm-vol --surf-ctx-vol --totalgray --euler --ctab /Users/uchidawataru/bin/freesurfer/ASegStatsLUT.txt --subject freesurfer \n
INFO: fsaverage subject does not exist in SUBJECTS_DIR
INFO: Creating symlink to fsaverage subject...
\n cd /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan; ln -s /Users/uchidawataru/bin/freesurfer/subjects/fsaverage; cd - \n
#--------------------------------------------
#@# BA_exvivo Labels lh Mon Oct  9 20:53:42 JST 2023
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA1_exvivo.label --trgsubject freesurfer --trglabel ./lh.BA1_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA2_exvivo.label --trgsubject freesurfer --trglabel ./lh.BA2_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA3a_exvivo.label --trgsubject freesurfer --trglabel ./lh.BA3a_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA3b_exvivo.label --trgsubject freesurfer --trglabel ./lh.BA3b_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA4a_exvivo.label --trgsubject freesurfer --trglabel ./lh.BA4a_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA4p_exvivo.label --trgsubject freesurfer --trglabel ./lh.BA4p_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA6_exvivo.label --trgsubject freesurfer --trglabel ./lh.BA6_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA44_exvivo.label --trgsubject freesurfer --trglabel ./lh.BA44_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA45_exvivo.label --trgsubject freesurfer --trglabel ./lh.BA45_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.V1_exvivo.label --trgsubject freesurfer --trglabel ./lh.V1_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.V2_exvivo.label --trgsubject freesurfer --trglabel ./lh.V2_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.MT_exvivo.label --trgsubject freesurfer --trglabel ./lh.MT_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.entorhinal_exvivo.label --trgsubject freesurfer --trglabel ./lh.entorhinal_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.perirhinal_exvivo.label --trgsubject freesurfer --trglabel ./lh.perirhinal_exvivo.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.FG1.mpm.vpnl.label --trgsubject freesurfer --trglabel ./lh.FG1.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.FG2.mpm.vpnl.label --trgsubject freesurfer --trglabel ./lh.FG2.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.FG3.mpm.vpnl.label --trgsubject freesurfer --trglabel ./lh.FG3.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.FG4.mpm.vpnl.label --trgsubject freesurfer --trglabel ./lh.FG4.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.hOc1.mpm.vpnl.label --trgsubject freesurfer --trglabel ./lh.hOc1.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.hOc2.mpm.vpnl.label --trgsubject freesurfer --trglabel ./lh.hOc2.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.hOc3v.mpm.vpnl.label --trgsubject freesurfer --trglabel ./lh.hOc3v.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.hOc4v.mpm.vpnl.label --trgsubject freesurfer --trglabel ./lh.hOc4v.mpm.vpnl.label --hemi lh --regmethod surface \n
\n mris_label2annot --s freesurfer --ctab /Users/uchidawataru/bin/freesurfer/average/colortable_vpnl.txt --hemi lh --a mpm.vpnl --maxstatwinner --noverbose --l lh.FG1.mpm.vpnl.label --l lh.FG2.mpm.vpnl.label --l lh.FG3.mpm.vpnl.label --l lh.FG4.mpm.vpnl.label --l lh.hOc1.mpm.vpnl.label --l lh.hOc2.mpm.vpnl.label --l lh.hOc3v.mpm.vpnl.label --l lh.hOc4v.mpm.vpnl.label \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA1_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.BA1_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA2_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.BA2_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA3a_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.BA3a_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA3b_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.BA3b_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA4a_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.BA4a_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA4p_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.BA4p_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA6_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.BA6_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA44_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.BA44_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.BA45_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.BA45_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.V1_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.V1_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.V2_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.V2_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.MT_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.MT_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.entorhinal_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.entorhinal_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/lh.perirhinal_exvivo.thresh.label --trgsubject freesurfer --trglabel ./lh.perirhinal_exvivo.thresh.label --hemi lh --regmethod surface \n
\n mris_label2annot --s freesurfer --hemi lh --ctab /Users/uchidawataru/bin/freesurfer/average/colortable_BA.txt --l lh.BA1_exvivo.label --l lh.BA2_exvivo.label --l lh.BA3a_exvivo.label --l lh.BA3b_exvivo.label --l lh.BA4a_exvivo.label --l lh.BA4p_exvivo.label --l lh.BA6_exvivo.label --l lh.BA44_exvivo.label --l lh.BA45_exvivo.label --l lh.V1_exvivo.label --l lh.V2_exvivo.label --l lh.MT_exvivo.label --l lh.perirhinal_exvivo.label --l lh.entorhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose \n
\n mris_label2annot --s freesurfer --hemi lh --ctab /Users/uchidawataru/bin/freesurfer/average/colortable_BA.txt --l lh.BA1_exvivo.thresh.label --l lh.BA2_exvivo.thresh.label --l lh.BA3a_exvivo.thresh.label --l lh.BA3b_exvivo.thresh.label --l lh.BA4a_exvivo.thresh.label --l lh.BA4p_exvivo.thresh.label --l lh.BA6_exvivo.thresh.label --l lh.BA44_exvivo.thresh.label --l lh.BA45_exvivo.thresh.label --l lh.V1_exvivo.thresh.label --l lh.V2_exvivo.thresh.label --l lh.MT_exvivo.thresh.label --l lh.perirhinal_exvivo.thresh.label --l lh.entorhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.stats -b -a ./lh.BA_exvivo.annot -c ./BA_exvivo.ctab freesurfer lh white \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.thresh.stats -b -a ./lh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab freesurfer lh white \n
#--------------------------------------------
#@# BA_exvivo Labels rh Mon Oct  9 20:56:57 JST 2023
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA1_exvivo.label --trgsubject freesurfer --trglabel ./rh.BA1_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA2_exvivo.label --trgsubject freesurfer --trglabel ./rh.BA2_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA3a_exvivo.label --trgsubject freesurfer --trglabel ./rh.BA3a_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA3b_exvivo.label --trgsubject freesurfer --trglabel ./rh.BA3b_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA4a_exvivo.label --trgsubject freesurfer --trglabel ./rh.BA4a_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA4p_exvivo.label --trgsubject freesurfer --trglabel ./rh.BA4p_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA6_exvivo.label --trgsubject freesurfer --trglabel ./rh.BA6_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA44_exvivo.label --trgsubject freesurfer --trglabel ./rh.BA44_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA45_exvivo.label --trgsubject freesurfer --trglabel ./rh.BA45_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.V1_exvivo.label --trgsubject freesurfer --trglabel ./rh.V1_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.V2_exvivo.label --trgsubject freesurfer --trglabel ./rh.V2_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.MT_exvivo.label --trgsubject freesurfer --trglabel ./rh.MT_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.entorhinal_exvivo.label --trgsubject freesurfer --trglabel ./rh.entorhinal_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.perirhinal_exvivo.label --trgsubject freesurfer --trglabel ./rh.perirhinal_exvivo.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.FG1.mpm.vpnl.label --trgsubject freesurfer --trglabel ./rh.FG1.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.FG2.mpm.vpnl.label --trgsubject freesurfer --trglabel ./rh.FG2.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.FG3.mpm.vpnl.label --trgsubject freesurfer --trglabel ./rh.FG3.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.FG4.mpm.vpnl.label --trgsubject freesurfer --trglabel ./rh.FG4.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.hOc1.mpm.vpnl.label --trgsubject freesurfer --trglabel ./rh.hOc1.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.hOc2.mpm.vpnl.label --trgsubject freesurfer --trglabel ./rh.hOc2.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.hOc3v.mpm.vpnl.label --trgsubject freesurfer --trglabel ./rh.hOc3v.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.hOc4v.mpm.vpnl.label --trgsubject freesurfer --trglabel ./rh.hOc4v.mpm.vpnl.label --hemi rh --regmethod surface \n
\n mris_label2annot --s freesurfer --ctab /Users/uchidawataru/bin/freesurfer/average/colortable_vpnl.txt --hemi rh --a mpm.vpnl --maxstatwinner --noverbose --l rh.FG1.mpm.vpnl.label --l rh.FG2.mpm.vpnl.label --l rh.FG3.mpm.vpnl.label --l rh.FG4.mpm.vpnl.label --l rh.hOc1.mpm.vpnl.label --l rh.hOc2.mpm.vpnl.label --l rh.hOc3v.mpm.vpnl.label --l rh.hOc4v.mpm.vpnl.label \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA1_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.BA1_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA2_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.BA2_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA3a_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.BA3a_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA3b_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.BA3b_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA4a_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.BA4a_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA4p_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.BA4p_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA6_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.BA6_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA44_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.BA44_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.BA45_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.BA45_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.V1_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.V1_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.V2_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.V2_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.MT_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.MT_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.entorhinal_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.entorhinal_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mri_label2label --srcsubject fsaverage --srclabel /Users/uchidawataru/Juntendo/DrFujita/test/test/ID02_Discovery_scan/fsaverage/label/rh.perirhinal_exvivo.thresh.label --trgsubject freesurfer --trglabel ./rh.perirhinal_exvivo.thresh.label --hemi rh --regmethod surface \n
\n mris_label2annot --s freesurfer --hemi rh --ctab /Users/uchidawataru/bin/freesurfer/average/colortable_BA.txt --l rh.BA1_exvivo.label --l rh.BA2_exvivo.label --l rh.BA3a_exvivo.label --l rh.BA3b_exvivo.label --l rh.BA4a_exvivo.label --l rh.BA4p_exvivo.label --l rh.BA6_exvivo.label --l rh.BA44_exvivo.label --l rh.BA45_exvivo.label --l rh.V1_exvivo.label --l rh.V2_exvivo.label --l rh.MT_exvivo.label --l rh.perirhinal_exvivo.label --l rh.entorhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose \n
\n mris_label2annot --s freesurfer --hemi rh --ctab /Users/uchidawataru/bin/freesurfer/average/colortable_BA.txt --l rh.BA1_exvivo.thresh.label --l rh.BA2_exvivo.thresh.label --l rh.BA3a_exvivo.thresh.label --l rh.BA3b_exvivo.thresh.label --l rh.BA4a_exvivo.thresh.label --l rh.BA4p_exvivo.thresh.label --l rh.BA6_exvivo.thresh.label --l rh.BA44_exvivo.thresh.label --l rh.BA45_exvivo.thresh.label --l rh.V1_exvivo.thresh.label --l rh.V2_exvivo.thresh.label --l rh.MT_exvivo.thresh.label --l rh.perirhinal_exvivo.thresh.label --l rh.entorhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.stats -b -a ./rh.BA_exvivo.annot -c ./BA_exvivo.ctab freesurfer rh white \n
\n mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.thresh.stats -b -a ./rh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab freesurfer rh white \n
