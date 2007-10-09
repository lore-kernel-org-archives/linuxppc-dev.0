Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2D6ADDE047
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 00:54:52 +1000 (EST)
Message-ID: <470B9634.1000706@freescale.com>
Date: Tue, 09 Oct 2007 09:54:44 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Build failure on treeboot-walnut.c
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
	<fa686aa40710082100h29c1d2a8hf939ca3306562fac@mail.gmail.com>
	<E83F8EDA-95EF-4116-A214-D008BA70135D@kernel.crashing.org>
	<470B93CC.6090400@freescale.com>
	<E5596C2A-8304-4158-B580-CFF9F86F814E@kernel.crashing.org>
In-Reply-To: <E5596C2A-8304-4158-B580-CFF9F86F814E@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> $ make V=1

make ARCH=ppc64 -f scripts/Makefile.build obj=arch/powerpc/boot 
arch/powerpc/boot/uImage powerpc-unknown-linux-gnu-gcc -m32 
-Wp,-MD,arch/powerpc/boot/.treeboot-walnut.o.d -Wall -Wundef 
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -Os -msoft-float -pipe 
-fomit-frame-pointer -fno-builtin -fPIC -nostdinc -isystem 
/_TOOLS_/.dist0/gnu-gcc-4.0.2-binutils-2.16.1-glibc-2.3.6-e300c2-powerpc-unknown-linux-gnu/i686-pc-linux2.4/bin/../lib/gcc/powerpc-unknown-linux-gnu/4.0.2/include 
-Iarch/powerpc/boot -I/temp/kumar.484/arch/powerpc/boot -mcpu=405 -c -o 
arch/powerpc/boot/treeboot-walnut.o arch/powerpc/boot/treeboot-walnut.c
Assembler messages:
Error: Internal assembler error for instruction icbt
Internal error, aborting at 
/tmp/crosstool/crosstool-0.42/build/powerpc-unknown-linux-gnu/gcc-4.0.2_e300-enabled-glibc-2.3.6/binutils-2.16.1-complete/gas/config/tc-ppc.c 
line 1314 in ppc_setup_opcodes
Please report this bug.
make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
make: *** [uImage] Error 2

ARCH=ppc64?  WTF?  I specifically said ARCH=powerpc on the make command line.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
