Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (unknown [205.230.130.11])
	by ozlabs.org (Postfix) with ESMTP id 65F7E67A8F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jan 2005 01:30:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 24 Jan 2005 09:30:13 -0500
Message-ID: <0007F077BB3476449151699150E8FEA205921E@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: lk2.4.25 compile fails with ELDK3.1
Reply-To: "Sanjay \(E-mail\)" <sanjay@tsi-telsys.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi! All,

I am new to this list, therefore, please correct my mistakes, if I do =
any.

I downloaded/installed ELDK 3.1 and also unzip lk2.4.25 which came with =
it. I used the default Xilinx ml300 config to compile the lk2.4.25. The =
following error is seen at the end of the compile:

ppc_4xx-objcopy -O elf32-powerpc \
        --add-section=3D.image=3D../images/vmlinux.gz \
        --set-section-flags=3D.image=3Dcontents,alloc,load,readonly,data =
\
        ../common/dummy.o image.o
ppc_4xx-ld -T ../ld.script -Ttext 0x00400000 -Bstatic -o zvmlinux head.o =
../common/relocate.o  misc-embedded.o .
./common/misc-common.o ../common/string.o ../common/util.o =
../common/serial_stub.o embed_config.o xiic_l.o ../co
mmon/ns16550.o image.o ../lib/zlib.a
ppc_4xx-objcopy -O elf32-powerpc zvmlinux zvmlinux -R .comment -R .stab =
-R .stabstr \
        -R .ramdisk -R .sysmap
mv zvmlinux ../images/zImage.
mv zvmlinux ../images/zImage.elf
mv: can't stat source zvmlinux
make[2]: *** [zImage] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.25/arch/ppc/boot/simple'
make[1]: *** [zImage] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.25/arch/ppc/boot'
make: *** [zImage] Error 2

I tried the same effort with ELDK 3.0 for lk2.4.24, that works fine. I =
have used different lk versions with ELDK 3.1 with the same result. Any =
ideas/pointers/explanations? They would greatly help.

Thanks,
Sanjay
