#!/bin/bash
#Phonebook script, its a work in progress

main_menu()
{
echo ""
echo -e "#############\033[0;92m = PHONEBOOK =\033[0;00m ###############" 
echo -e "## \033[0;92m1)\033[0;00m Add  \033[0;92m2)\033[0;00m Search  \033[0;92m3)\033[0;00m Delete  \033[0;92m4)\033[0;00m Quit ##"
echo "###########################################"
echo ""
}

book=~/.addrbook
export book

add_name()
{
printf "Enter name: "
read name
if [ -z "$name" ];then 
   printf "\nNothing to do, returning to Main Menu\n"
   return 0
fi
if grep -w "${name}" $book 2>/dev/null;then 
   printf "\nName already exists, returning to Main Menu\n"
   return 0
fi
printf "Enter number: "
read number
if [ -z $number ]; then
   printf "\nNo number added, returning to Main Menu\n" 
   return 0
fi
echo "$name: $number" >> $book
printf "\nName $name with number $number added to Phonebook\n"
}

search_name()
{
  
 echo ""
 echo -e "########\033[0;92m = Search Menu =\033[0;00m #########" 
 echo -e "# \033[0;92m1)\033[0;00m List all \033[0;92m2)\033[0;00m Search  \033[0;92m3)\033[0;00m Back #"
 echo "##################################"
 echo ""
while :
do 
read search_name
case $search_name in
    1) search_list 2>/dev/null;;
    2) search_grep ;;
    3) search_exit ;;
    *) printf "Nothing to do, select options 1 2 or 3: " ;;
esac
done
}

search_exit()
{
echo "Going back to Main Menu"
break
return 
}

search_list()
{
echo "Listing all names/numbers:" 
cat $book | sort -n  
search_name
break
return 
}

search_grep() #sets the empty string for search case
{
printf "Enter name/number: "
read var
if [ -z "$var" ];then
   echo "Nothing to do, returning to Search Menu"
   search_name
   break
   return
fi
grep "$var" $book 2>/dev/null
search_name
break
return 
}

delete_name()
{
printf "Enter name to delete: "
read var
if [ -z "$var" ]; then
     
    echo "Nothing entered, returning to menu"
    return $?
    main_menu
fi
#if line not empty starting to delete
varx=$(grep -m 1 "\b${var}\b" $book)
if [ -z "${varx}" ]; then
echo "No match found"
return
main_menu
else  
grep -v  "$varx" $book > ${book}.tmp && mv ${book}.tmp $book 
echo "Name $var deleted from phonebook"
fi
}

edit_names()
{
printf "Enter name/number to edit: "
read var
grep -m 1 "\b$var\b" $book
#var_2=var   #$(grep -m 1 "\b${var}\b" $book)
if [ -z "$var" ];then
echo "No match, returning to Main Menu"
return $?
main_menu
fi
printf "Is ${var} the name/number you want to edit? [y/n]: "
read y
if [ "$y" != "n" ]; then
printf "New name/number for $var: "
read var_3
if [ -z "$var_3" ]; then
echo "Nothing to do, returning to Main Menu"
return
main_menu
else
if grep -w "$var_3" $book; then
echo "Name/number already in Phonebook"
return
main_menu
fi
sed -i "s@${var}@${var_3}@" $book
return
main_menu
fi
fi
}


#main script starts here

while :  
do
main_menu
read quit_string
case $quit_string in
    1) add_name  ;;
    2) search_name ;;
    3) delete_name ;;
    4) echo "Thank you, come again!" && exit $? ;;
    5) edit_names ;;
    *) printf "Nothing to do, select options 1 2 3 or 4: " ;;
esac
done
