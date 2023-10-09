#!/bin/bash
set -e

# Wataru Uchida, 202301009, 
function sampling_mean() {
    ID=$1
    map=$2
    vendor=$3
    mask=$4
    scan=$5
    atlas=$6
    subj="${ID}_${vendor}_${scan}"
    input=$(echo "${map}" | cut -d. -f1)
    fslstats "./${subj}/${input}" -k "./${subj}/${atlas}/${mask}" -n -M >> "0_Results/param_mean/${input}.${atlas}.${vendor}.${scan}.txt"
}

function sampling_median() {
    ID=$1
    map=$2
    vendor=$3
    mask=$4
    scan=$5
    atlas=$6
    subj="${ID}_${vendor}_${scan}"
    input=$(echo "${map}" | cut -d. -f1)
    fslstats "./${subj}/${input}" -k "./${subj}/${atlas}/${mask}" -n -P 50 >> "0_Results/param_median/${input}.${atlas}.${vendor}.${scan}.txt"
}


function process_map() {
    ID=$1
    map=$2
    vendor=$3
    mask_file=$4
    scan=$5
    atlas=$6
    sampling_mean "$ID" "$map" "$vendor" "$mask_file" "$scan" "$atlas"
    sampling_median "$ID" "$map" "$vendor" "$mask_file" "$scan" "$atlas"
}

function usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "  -m   Specify maps (comma-separated). example: PDMAP.nii.gz,T1MAP.nii.gz,T2MAP.nii.gz"
    echo "  -v   Specify vendors (comma-separated). example: Skyra,Prisma"
    echo "  -s   Specify scans (comma-separated). example: scan,rescan"
    echo "  -a   Specify Atlas. nodes_DK or nodes_aseg or nodes_wmparc"
    echo "  -h   Display this help message"
}


# Option
OPTIND=1
atlas="x"
while getopts ":m:v:s:a:h" opt; do
  case $opt in
    m) IFS=',' read -ra maps <<< "$OPTARG" ;;
    v) IFS=',' read -ra vendors <<< "$OPTARG" ;;
    s) IFS=',' read -ra scans <<< "$OPTARG" ;;
    a) IFS=',' read -ra atlas <<< "$OPTARG" ;;
    h) usage; exit 0 ;;
    \?) echo "Invalid option -$OPTARG" >&2; usage; exit 1 ;;
  esac
done

if [ $OPTIND -eq 1 ]; then
    echo "Error: No options specified."
    usage
    exit 1
fi

if [ $atlas = "x" ]; then
    echo "Error: Atlas was not specified. Please specify using -a"
    usage
    exit 1
fi

trap 'echo "全ての処理を中断します..."; exit 1' INT

export -f process_map sampling_mean sampling_median 
mkdir -p 0_Results/results_mean 0_Results/param_mean 0_Results/results_median 0_Results/param_median 0_Results/temp

# Total task count and current task count
TOTAL_TASKS=0
CURRENT_TASK=0

echo "ID" > 0_Results/temp/ID
echo "region" > 0_Results/temp/region

for dir in $(\ls -1 | grep -v Results); do
    ID=$(basename "$dir" | cut -d_ -f1)
    for mask in $(\ls -1 ${dir}/${atlas}/*.nii.gz | cut -d/ -f3); do
        echo $ID >> 0_Results/temp/ID
        echo $mask >> 0_Results/temp/region
    done
done

# Calculate total tasks first
for dir in $(\ls -1 | grep -v Results); do
    for vendor in "${vendors[@]}"; do
        for scan in "${scans[@]}"; do
            for mask in $(\ls -1 ${dir}/${atlas}/*.nii.gz); do
                TOTAL_TASKS=$((TOTAL_TASKS + ${#maps[@]}))
            done
        done
    done
done

for vendor in "${vendors[@]}"; do
    for scan in "${scans[@]}"; do
        for map in "${maps[@]}"; do
            input=$(echo "${map}" | cut -d. -f1)
            echo ${vendor}.${scan} > "0_Results/param_mean/${input}.${atlas}.${vendor}.${scan}.txt"
            echo ${vendor}.${scan} > "0_Results/param_median/${input}.${atlas}.${vendor}.${scan}.txt"
        done
    done
done

for dir in $(\ls -1 | grep -v Results); do
    ID=$(basename "$dir" | cut -d_ -f1)

    for vendor in "${vendors[@]}"; do
        for scan in "${scans[@]}"; do
            for mask in $(\ls -1 ${dir}/${atlas}/*.nii.gz); do
                mask_file=$(basename "$mask")
                printf "%s\n" "${maps[@]}" | xargs -I {} -P ${#maps[@]} bash -c "process_map '$ID' '{}' '$vendor' '$mask_file' '$scan' '$atlas'"

                # Increment the current task count and display progress
                CURRENT_TASK=$((CURRENT_TASK + 3))
                PROGRESS=$((100 * CURRENT_TASK / TOTAL_TASKS))
                echo "Progress: $PROGRESS% ($CURRENT_TASK/$TOTAL_TASKS)"
            done
        done
    done
done

for map in "${maps[@]}"; do
    input=$(echo "${map}" | cut -d. -f1)
    paste 0_Results/temp/ID 0_Results/temp/region $(find 0_Results/param_mean -name "${input}.${atlas}*.txt" | sort | tr "\n" " ") > ./0_Results/results_mean/${input}_${atlas}_results_mean.txt
    paste 0_Results/temp/ID 0_Results/temp/region  $(find 0_Results/param_median -name "${input}.${atlas}*.txt" | sort | tr "\n" " ") > ./0_Results/results_median/${input}_${atlas}_results_median.txt
done
