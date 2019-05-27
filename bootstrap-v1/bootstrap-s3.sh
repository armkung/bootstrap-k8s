kubectl --kubeconfig config -n rook-ceph exec -ti \
$(kubectl --kubeconfig config -n rook-ceph get pod -l app=rook-ceph-tools -o jsonpath={.items..metadata.name}) \
-- bash -c '
  # export USERNAME=admin
  
  # radosgw-admin user rm --uid=${USERNAME}
  if ! hash s3cmd 2>/dev/null; then
    yum --assumeyes install s3cmd
  fi

  # if ! radosgw-admin user info --uid=${USERNAME}; then
  #   radosgw-admin user create \
  #   --uid ${USERNAME} --display-name "Admin User" \
  #   --rgw-realm=s3-store --rgw-zonegroup=s3-store
  # fi
  
  # user=$(radosgw-admin user info --uid=${USERNAME})
  # access_key=$(echo $user | jq -r ".keys[0].access_key")
  # secret_key=$(echo $user | jq -r ".keys[0].secret_key")

  export PUBLIC_HOST=tsli-api.appman.co.th/s3

  export AWS_HOST=s3.minio:9000
  export AWS_ACCESS_KEY_ID=OA0A3308VQ2QNQ70MTWF
  export AWS_SECRET_ACCESS_KEY=tlgmd5idweGiY4S3TeozQNkX6Wo6EP1QlQ2ewWNl

  s3cmd mb --no-ssl --host=${AWS_HOST} --host-bucket=  s3://tsli-documents
  s3cmd ls --no-ssl --host=${AWS_HOST}
  
  echo "hello world" | s3cmd put \
  --no-ssl --host=${AWS_HOST} --host-bucket= \
  - s3://tsli-documents/test.txt
  
  s3cmd signurl --host=${PUBLIC_HOST} --host-bucket= \
  s3://tsli-documents/test.txt +3600
'

# kubectl --kubeconfig config patch service rook-ceph-rgw-s3-store \
# -n rook-ceph --type json --patch \
# '[{"op": "replace", "path": "/spec/type", "value": "NodePort"}, {"op": "add", "path": "/spec/ports/0/nodePort", "value": 31000}]'
