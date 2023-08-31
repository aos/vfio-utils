HUGEPAGES=8192

function activate_hugepages {
  echo "Allocating hugepages..."
  echo $HUGEPAGES > /proc/sys/vm/nr_hugepages
  ALLOC_PAGES=`cat /proc/sys/vm/nr_hugepages`

  TRIES=0
  while (( $ALLOC_PAGES != $HUGEPAGES && $TRIES < 1000 ))
  do
    echo 1 > /proc/sys/vm/compact_memory
    echo $HUGEPAGES > /proc/sys/vm/nr_hugepages
    ALLOC_PAGES=`cat /proc/sys/vm/nr_hugepages`
    echo "Tried to allocate hugepages. Got pages $ALLOC_PAGES / $HUGEPAGES"
    let TRIES+=1
  done

  if [ "$ALLOC_PAGES" -ne "$HUGEPAGES" ]
  then
    echo "Not able to allocate hugepages"
    echo 0 > /proc/sys/vm/nr_hugepages
    exit 1
  fi
}

function free_hugepages {
  echo "Freeing hugepages..."

}
