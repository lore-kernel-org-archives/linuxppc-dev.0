Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20021010100901.9814.qmail@web8005.mail.in.yahoo.com>
Date: Thu, 10 Oct 2002 03:09:01 -0700 (PDT)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: how to buitl ramdisk image..
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,
I am using linux2.4.4 for fads860T
can anyone tell me how to build an ramdisk.image.gz
I made
> make  zImage.initrd

but it gave this error

powerpc-linux-ld -T ../vmlinux.lds -Ttext 0x00180000
-o zvmlinux.tmp head.o misc.o ../coffboot/zlib.o
m8xx_tty.o
powerpc-linux-objcopy -O elf32-powerpc -R .comment
--add-section=image=../coffboot/vmlinux.gz \
        zvmlinux.tmp zvmlinux
rm zvmlinux.tmp
powerpc-linux-ld -T ../vmlinux.lds -Ttext 0x00180000
-o zvmlinux.initrd.tmp1 head.o misc.o
../coffboot/zlib.o m8xx_tty.o
powerpc-linux-objcopy -O elf32-powerpc -R .comment \
        --add-section=initrd=ramdisk.image.gz \
        --add-section=image=../coffboot/vmlinux.gz \
        zvmlinux.initrd.tmp1 zvmlinux.initrd1
powerpc-linux-objcopy: cannot stat: ramdisk.image.gz:
No such file or directory
make[1]: *** [zvmlinux.initrd] Error 1
make[1]: Leaving directory
`/usr/src/linux-2.4.4-2002-03-21/arch/ppc/mbxboot'
_______________________________________________________
bye!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
