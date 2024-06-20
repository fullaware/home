if [ ! -f ./phase1.phase ];
then
    echo "Beginning Phase 1"
    sudo dnf info git-core
    touch ./phase1.phase 
    exit 0
else
    if [ ! -f ./phase2.phase ];
    then
        echo "Beginning Phase 2"
        lspci | grep VGA 
        touch ./phase2.phase
        exit 0
    else
       if [ ! -f ./phase3.phase ];
       then
           echo "Beginning Phase 3"
           lspci | grep 3D
           touch ./phase3.phase
           exit 0
       fi
    fi
fi

