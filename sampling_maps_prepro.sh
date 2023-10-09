#!/bin/bash

# export FREESURFER_HOME=~/bin/freesurfer_6.0.0
# source "$FREESURFER_HOME/SetUpFreeSurfer.sh"
lut_path=~/bin/jtd_bin

function freesurfer_run () {
    subj=$1
    t1wi=$2
    
    # recon-all -i $subj/$t1wi -subjid freesurfer -sd $subj -openmp 1 -all -brainstem-structures
    recon-all -i $subj/$t1wi -subjid freesurfer -sd $subj -openmp 1 -all
    wait
}

function freesurfer_postproc () {
    subj=$1
    t1wi=$2
    lut_path=$3
    mri_label2vol --seg ./$subj/freesurfer/mri/aparc+aseg.mgz --temp ./$subj/$t1wi --o ./$subj/aparc+aseg_T1.nii.gz --regheader ./$subj/freesurfer/mri/aparc+aseg.mgz
    mri_label2vol --seg ./$subj/freesurfer/mri/aseg.mgz --temp ./$subj/$t1wi --o ./$subj/aseg_T1.nii.gz --regheader ./$subj/freesurfer/mri/aseg.mgz
    mri_label2vol --seg ./$subj/freesurfer/mri/wmparc.mgz --temp ./$subj/$t1wi --o ./$subj/wmparc_T1.nii.gz --regheader ./$subj/freesurfer/mri/wmparc.mgz
    labelconvert ./$subj/aparc+aseg_T1.nii.gz $lut_path/FreeSurferColorLUT.txt $lut_path/fs_default.txt ./$subj/nodes_T1.nii.gz -force
    labelconvert ./$subj/aseg_T1.nii.gz $lut_path/FreeSurferColorLUT.txt $lut_path/fs_default_aseg.txt ./$subj/nodes_aseg.nii.gz -force
    labelconvert ./$subj/wmparc_T1.nii.gz $lut_path/FreeSurferColorLUT.txt $lut_path/fs_default_wmparc.txt ./$subj/nodes_wmparc.nii.gz -force

    mkdir -p ./$subj/nodes_DK ./$subj/nodes_aparc ./$subj/nodes_aseg ./$subj/nodes_wmparc
    desikan_split_no-FIRST.sh $subj $subj/nodes_DK
    wait
    for j in $(\ls -1 ./$subj/nodes_DK | grep -v -e Right -e Left |cut -d"-" -f2-);do
        cp ./$subj/nodes_DK/*${j} ./$subj/nodes_aparc/$j
    done

    desikan_split_aseg.sh $subj $subj/nodes_aseg
    desikan_split_wmparc.sh $subj $subj/nodes_wmparc
    find $subj -type f -name wm*corpuscallosum.nii.gz -delete
    find $subj -type f -name wm*unknown.nii.gz -delete

}

function usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "  -i   Specify the input T1WI file name"
    echo "  -p   Specify the number of process"
    echo "  -h   Display this help message"
}

# Option
OPTIND=1
while getopts ":i:p:h" opt; do
  case $opt in
    i) IFS=',' read -ra t1wi <<< "$OPTARG" ;;
    p) IFS=',' read -ra proc <<< "$OPTARG" ;;
    h) usage; exit 0 ;;
    \?) echo "Invalid option -$OPTARG" >&2; usage; exit 1 ;;
  esac
done

if [ $OPTIND -eq 1 ]; then
    echo "Error: No options specified."
    usage
    exit 1
fi

trap 'echo "全ての処理を中断します..."; exit 1' INT
export -f freesurfer_run freesurfer_postproc

# \ls -1 | xargs -I{} -P$proc bash -c "freesurfer_run '{}' '$t1wi'"
# wait
\ls -1 | xargs -I{} -P$proc bash -c "freesurfer_postproc '{}' '$t1wi' '$lut_path'"
