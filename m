Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20021204105147.13636.qmail@web8007.mail.in.yahoo.com>
Date: Wed, 4 Dec 2002 02:51:47 -0800 (PST)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: glibc 2.2.3  undefined reference  
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everbody ,

I had been very unsuccessful in trying to run the
application on linux kernel 2.4.4
I had compiled glibc-2.2.3 without the option
 --without-fp
and hence  used to get either illegal instruction or
segmentation fault...when everi tried to run the
application .theni read from the mailing list that
glibc need to be compiled with the option
"--without-fp"
Now i have given the configure line as
./configure --host=powerpc-linux \
> --enable-add-ons --with-headers=/kernel/include \
> --without-fp
CFLAGS="msoft-float -D_SOFT_FLOAT -mcpu=860"

but still i end up with errors  at link time ....
****************************************************
rm -f ../libc.so.6.new
/bin/sh ../scripts/rellns-h ../libc.so
../libc.so.6.new
mv -f ../libc.so.6.new ../libc.so.6 powerpc-linux-gcc
-nostdlib -nostartfiles -o iconv_prog
-Wl,-dynamic-linker==/lib/ld.so.1   ../csu/crt1.o
../csu/crti.o `powerpc-linux-gcc
--print-file-name=crtbegin.o` iconv_prog.o
iconv_charmap.o charmap.o charmap-dir.o linereader.o
dummy-repertoire.o simple-hash.o xstrdup.o xmalloc.o
-Wl,-rpath-nk=..:../math:../elf:../dlfcn:../nss:../nis:../rt:../resolv:../crypt:../linuxthreads
../libc.so.6 ../libc_nonshared.a -lgcc
`powerpc-linux-gcc --print-file-name=crtend.o`
../csu/crtn.o
../libc.so.6: undefined reference to
`_dl_debug_printf'
../libc.so.6: undefined reference to
`_dl_check_map_versions'../libc.so.6: undefined
reference to `_dl_nloaded'../libc.so.6: undefined
reference to `_dl_lookup_versioned_symbol_skip'
../libc.so.6: undefined reference to
dl_profile_output'
../libc.so.6: undefined reference to
`__libc_stack_end'
collect2: ld returned 1 exit status
make[1]: *** [iconv_prog] Error 1
make[1]: Leaving directory `/usrsrc/glibc-2.2.3/iconv'
make: *** [iconv/others] Error 2
*****************************************************
I really dont know how to move further ...any help
fairly welcomed ....
Thankyou
Rekha


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
