Return-Path: <Jogi95@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by ozlabs.org (Postfix) with ESMTP id 0FA3FDDFDF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 02:19:59 +1100 (EST)
Date: Wed, 09 Jan 2008 16:19:55 +0100
Message-Id: <524013725@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux for ml310
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

First I want to thank you for you fast and useful answer last time.
I decided to use the kernel 2.6 for my ml310 now.

I downloaded this Kernel:
http://git.secretlab.ca/git/gitweb.cgi=3Fp=3Dlinux-2.6-virtex.git;a=3Dsnapshot;h=
=3Dd7ed933b578d9c4dec0e23a5a6f78c464b31c47c;sf=3Dtbz2
Is this a complete Kernel=3F I don't really understand this whole git-tree s=
tuff.
then i copied the arch/ppc/configs/ml300=5Fdefconfig to .config.
I used an edk9.1 with linux=5F2=5F6 as OS for the ppc405=5F0,  0x10000000 for me=
mory size, 100000000 for uart16550 bus clock freq and set the target direc=
tory. Under connected=5Fperiphs where: RS232=5FUart, SPI=5FEEPROM, PCI32=5FBRIDGE,=
 SysACE=5FCompactFlash and opb=5Fintc=5F0.
At Software I pressed the "Generate Libaries and BSPs" Button and copied t=
he generated xparameters.h to linux-2.6-virtex/arch/ppc/platforms/4xx/xpar=
ameters.
I tried to compile with=20
make ARCH=3Dppc CROSS=5FCOMPILE=3Dpowerpc-405-linux-gnu- zImage
but it soon aborted with:
---------------------------
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      arch/ppc/syslib/xilinx=5Fpic.o
In file included from arch/ppc/syslib/xilinx=5Fpic.c:16:
arch/ppc/platforms/4xx/xparameters/xparameters.h:14:26: linux/config.h: No=
 such file or directory
make[1]: *** [arch/ppc/syslib/xilinx=5Fpic.o] Error 1
make: *** [arch/ppc/syslib] Error 2
------------------------------

Can you help me=3F
Is there any tutorial (beside http://wiki.secretlab.ca/index.php/Linux=5Fon=5F=
Xilinx=5FVirtex) which provides detailed information=3F
Which Kernel should I use (And where to get it)=3F
Are ther eany patches necessary=3F
As crosscompiler I used crosstool with:
eval `cat powerpc-405.dat gcc-4.1.0-glibc-2.3.6.dat` sh all.sh --notest

I hope I don't bother you too much
Greetings & Thanks
Joachim
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220
