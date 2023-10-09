

import argparse
import numpy as np
import nibabel as nib 

def T1WI_calculation(niftifile, invtime, out):
    nii = nib.load(niftifile)
    affine=nii.affine.copy()

    img = nii.get_data()
    mask = img.copy()
    mask=np.where(mask>0, 1, mask)

    img = np.exp(-1 * invtime / img)
    t1wi = mask - 2 * img
    # t1wi = np.where(t1wi<0, 0, t1wi)

    t1nii=nib.Nifti1Image(t1wi,affine=affine)
    nib.save(t1nii, out)

def T2WI_calculation(niftifile, echotime, out):
    nii = nib.load(niftifile)
    affine=nii.affine.copy()

    img = nii.get_data()
    mask = img.copy()
    mask=np.where(mask>0, 1, mask)

    t2wi = np.exp(-1 * echotime / img)
    # t2wi = np.where(t2wi<0, 0, t2wi)

    t2nii=nib.Nifti1Image(t2wi,affine=affine)
    nib.save(t2nii, out)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-f','--fname')
    parser.add_argument('-m','--metric') # T1WI or T2WI
    parser.add_argument('-p','--parameter') # Inversion time for T1WI, Echo time for T2WI


args = parser.parse_args()
if args.metric == "T1WI":
    if args.parameter:
        invtime = np.float(args.parameter)
    else:    
        invtime = 1.3 # Default in sec. If it doesn't work, set the unit to "ms" and re-run.
    print("T1WI Calculating ...")
    print("Inversion Time="+str(invtime))
    T1WI_calculation(args.fname, invtime, "T1WI.nii.gz")
elif args.metric == "T2WI":
    if args.parameter:
        echotime = np.float(args.parameter)
    else:
        echotime = 100
    print("T2WI Calculating ...")
    print("Echo Time="+str(echotime))
    T2WI_calculation(args.fname, echotime, "T2WI.nii.gz")
else:
    print("Error: --metric was not specified")

