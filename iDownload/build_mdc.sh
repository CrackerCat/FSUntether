#!/bin/zsh
cd "${0:A:h}"

rm -rf build
mkdir build
clang -arch arm64 -isysroot ~/theos/sdks/iPhoneOS14.5.sdk -o build/libexploit.a Exploit/vm_unaligned_copy_switch_race.c -c
clang -arch arm64 -isysroot ~/theos/sdks/iPhoneOS14.5.sdk -o build/libhelpers.a Exploit/helpers.m -c -fmodules
clang -arch arm64 -isysroot ~/theos/sdks/iPhoneOS14.5.sdk -o build/libgfda.a Exploit/grant_full_disk_access.m -c -fmodules
clang -arch arm64 -isysroot ~/theos/sdks/iPhoneOS14.5.sdk -o TestFlightServices server-dylib-mdc.m -framework MobileCoreServices -framework Foundation -Lbuild -lhelpers -lexploit -lgfda -dynamiclib

cd -
