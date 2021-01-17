#!/bin/bash

# dependencies: sed, arduino-cli, tr

main() {
    echo "*************** Welcome to USB Passkey Generator ***************"
    echo "Please select one on the following action **********************"
    echo ""
    OPTION_1="Generate and load new password"
    OPTION_2="Set password lenght"
    OPTION_3="Load custom password"
    OPTION_4="Quit"
    CHARSET="A-Xa-x0-9"
    lenght=20
    OPTIONS=("Generate and load new password" "Set password lenght" "Load custom password" "Quit")
    select opt in "${OPTIONS[@]}"; do
        case $opt in
            $OPTION_1)
                echo "Password lenght: $lenght"
                generate_passwd
                load_passwd
                echo "Password: $passwd"
                exit
                ;;
            $OPTION_2)
                echo "Please enter password lenght..."
                #please filter this input (only numbers allowed)
                read lenght
                echo "Password lenght set to $lenght"
                ;;
            $OPTION_3)
                echo "Please enter custom password..."
                read passwd
                echo "Password set to $passwd"
                load_passwd
                exit
                ;;
            $OPTION_4)
                echo "Quit"
                exit
            break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

load_passwd()
{
    mkdir passwd
    cp digispark/digispark.ino passwd/passwd.ino
    # Replace passwd with new password to load
    sed -i '' "s/passwd/$passwd/" passwd/passwd.ino
    arduino-cli compile --fqbn digistump:avr:digispark-tiny passwd
    arduino-cli upload --fqbn digistump:avr:digispark-tiny passwd
    rm -dr passwd
    return
}
generate_passwd()
{
    passwd=$(LC_ALL=C tr -dc $CHARSET </dev/urandom | head -c $lenght)
    return
}

main "$@"