safe_archive=${1}
optional=${2}

safe=`unzip -l $safe_archive | grep "SAFE" | head -n 1 | awk '{ print $4 }' | xargs -I {} basename {}`

[ -n "$optional" ] && safe=$optional/$safe
mkdir -p $safe

for annotation in `unzip -l "$safe_archive" | grep annotation | grep .xml | grep -v calibration | awk '{ print $4 }'`
do 
  unzip -o -j $safe_archive "$annotation" -d "$safe/annotation" 1>&2 
done

for measurement in `unzip -l $safe_archive | grep measurement | grep .tiff | awk '{ print $4 }'`
do
  unzip -o -j $safe_archive "$measurement" -d "$safe/measurement" 1>&2 
done

echo $safe
