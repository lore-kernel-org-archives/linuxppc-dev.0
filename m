Message-ID: <20021105111412.27408.qmail@web8005.mail.in.yahoo.com>
Date: Tue, 5 Nov 2002 03:14:12 -0800 (PST)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: glibc 2.2.5 error
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI,
when i try to compile glibc 2.2.5 for the
powerpc-linux target on a i686 host system ..i get the
following errors.can i know which version of glibc
should i use ?
i did a configure and set --target=powerpc-linux
--host=i686-pc-linux-gnu
>make
*************************************************
gcc -nostdlib -nostartfiles -o iconvconfig
-Wl,-dynamic-linker=/usr/local/lib/ld-linux.so.
2    ../csu/crt1.o ../csu/crti.o `gcc
--print-file-name=crtbegin.o` iconvconfig.o strtab.o
xmalloc.o
-Wl,-rpath-link=..:../math:../elf:../dlfcn:../nss:../nis:../rt:../resolv:../cryp
t ../libc.so.6 ../libc_nonshared.a -lgcc `gcc
--print-file-name=crtend.o` ../csu/crtn.o
../libc.so.6: undefined reference to `fileno_unlocked'
collect2: ld returned 1 exit status
make[1]: *** [iconvconfig] Error 1
make[1]: Leaving directory
`/usr/src/glibc-2.2.5/iconv'
make: *** [iconv/others] Error 2
*****************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
