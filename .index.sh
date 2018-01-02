#!/bin/bash

INDEX=index.html

for wheel in *.whl; do
    if [ $(unzip -l $wheel | grep -c '\.so\|scripts') -eq 0 ]; then
	read -p "Remove non-binary $wheel?"
	[ "${RESPONSE^^}" == "Y" ] && rm -f $wheel
    fi
done

echo Creating index...

cat << EOF > $INDEX
<!DOCTYPE html>
<html>
<body>
<ul>
EOF

for wheel in *.whl; do
    cat << EOF >> $INDEX
  <li><a href="$(basename $wheel)">
    $(basename $wheel)
  </a></li>
EOF
done

cat << EOF >> $INDEX
</ul>
</body>
</html>
EOF

echo Done.
