Message-ID: <D73A25AA6E54D511AD74009027B1110F2C8693@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'rekha gvv'" <rekhagvvc@yahoo.co.in>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: how to buitl ramdisk image..
Date: Thu, 10 Oct 2002 09:10:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In the documentation directory there is an initrd.txt file that explains how
to make it.

-----Original Message-----
From: rekha gvv [mailto:rekhagvvc@yahoo.co.in]
Sent: Thursday, October 10, 2002 6:09 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: how to buitl ramdisk image..



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
