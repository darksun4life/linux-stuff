#!/bin/bash
#users manipulation script, work in progress

trap '' 2
main_menu() {
        echo
        echo "1) List users 2) Search by range 3) Search/Modify user 4) Exit"
        echo
}

list() {
        echo
        awk -F ":" '$3 >= 1000  {print ;}' /etc/passwd
}

iterate() {
        printf "Enter 1st range: "
        read range1
        if [ -z $range1 ]; then
            echo "Nothing to do, going fishing"
            return 0
        fi

        case $range1 in
           *[!0-9]*) echo "Not a number" && iterate ;;
        esac

        printf "Enter 2nd range: "
        read range2
        while [ -z $range2 ]; do
                printf "Enter 2nd range: "
                read range2
        done

        case $range2 in
           *[!0-9]*) echo "Not a number" && iterate ;;
        esac

        echo "Searching between $range1 - $range2, might take some time"
        for ((i=range1;i<=range2;i++)); do
            grep -w $i /etc/passwd
        done
}

search() {
        printf "Enter user: "
        read var1
        echo
        grep "$var1" /etc/passwd
}

add_user() {
        echo "Creating user $var"
        useradd $var
        return
}

edit_names() {
        printf "Enter USER/UID/GID to work on: "
        read var
        var2=$(grep -w "$var" /etc/passwd)
        if [ -z "$var2" ]; then
                echo "No such user, create it? [y/n]"
                read varxx
                case $varxx in
                        y) add_user ;;
                        n) return ;;
                        *) return ;;

                esac



        elif [ -z "$var" ]; then  #return empty
                echo "Nothing to do, going fishing"
                return
        fi

        grep -m 1 "\b$var\b" /etc/passwd > .tmp.txt
        id $var
        echo
        user=$(awk -F : '{print $1}' .tmp.txt)
        curruid=$(awk -F : '{print $3}' .tmp.txt)
        currgid=$(awk -F : '{print $4}' .tmp.txt)
        number='^[0-9]+$'
        printf "Enter new UID for $user: [Return for defaults \"$curruid\"]: "
        read uid
        if
           nf=$(grep -m 1 "\b$uid\b" /etc/passwd | cut -d : -f 1)
           [ "${user}" == "${nf}" ]; then
           usermod -u $uid $user
           printf "Enter GID [Return for defaults \"$curruid\"]: "
        elif [ -z "$uid" ]; then
           printf "Skipping, enter GID [Return for defaults \"$currgid\"]: "
        elif ! [[ "$uid" =~ $number ]]; then
           echo "$uid is not a number, nothing to do!"
           return
        elif
           nf=$(grep -m 1 "\b$uid\b" /etc/passwd | cut -d : -f 1)
           uidexit=$(grep -cm 1 "\b$uid\b" /etc/passwd)
           [ $uidexit -ge 1 ]; then
           echo "UID in use by user $nf"
           return
        else
           usermod -u $uid $user
           echo "UID for user $user changed to $uid"
           printf "Enter GID [Return for defaults \"$currgid\"]: "
        fi

        read gid
        if [ -z $gid ]; then
                echo "Default value selected"
        else
            currgr=$(grep -m 1 "\b$gid\b" /etc/group)
            if [ -z $currgr ]; then
                    echo "Group not found, create it? [y/n]: "
                    read currgr
                    case $currgr in
                        y) echo "User $user added to new Group $gid" && groupadd $gid && usermod -aG $gid $user && edit_names ;;
                        n) echo "Nothing to do" && edit_names ;;
                    esac
                else
                usermod -aG $gid $user
                echo "GID for user $user changed to $gid"
                main_menu
                fi
        fi
}

getout() {
        if [ -e .tmp.txt ]; then
                rm .tmp.txt
                exit
        else
                exit
        fi
}


# Main ---
while :
do
        main_menu
        read var1
        case $var1 in
           1) printf "Listing all users\n" && list ;;
           2) echo "Starting search" && iterate ;;
           3) edit_names  ;;
           4) echo "Bye bye" && getout ;;
           *) echo "Nothing to do, going fishing" ;;

        esac
done
trap 2

