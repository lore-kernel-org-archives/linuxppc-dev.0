Return-Path: <tglx@linutronix.de>
Received: from debian.tglx.de (unknown [213.239.205.147])
	by ozlabs.org (Postfix) with ESMTP id 8E4022BF13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 01:49:29 +1100 (EST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041215143518.GC22316@smtp.west.cox.net>
References: <20041215152142.1.patchmail@tglx>
	<20041215143518.GC22316@smtp.west.cox.net>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 15:49:26 +0100
Message-Id: <1103122166.3406.174.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Compile 6xx specific code only for 6xx machines
Reply-To: tglx@linutronix.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2004-12-15 at 07:35 -0700, Tom Rini wrote:
> On Wed, Dec 15, 2004 at 03:21:43PM +0100, tglx@linutronix.de wrote:
> 
> > The 6xx specific mmu functions in arch/boot/common/util.S break the compile for
> > other platforms. Compile them for 6xx only.
> 
> They, er, do?  Can you please post a log?  And what toolchain are you
> using?  I'd make a quick guess that the binutils folks are being overly
> 'helpful' again, but perhaps I'm just jaded. :)

I'm compiling for 8540 (e500)

  AS      arch/ppc/boot/common/util.o
/home/tglx/work/repos/linux-ebrain/2.6.10-
rc3/arch/ppc/boot/common/util.S: Assembler messages:
/home/tglx/work/repos/linux-ebrain/2.6.10-
rc3/arch/ppc/boot/common/util.S:76: Error: Unrecognized opcode: `mtsrin'
make[3]: *** [arch/ppc/boot/common/util.o] Error 1
make[2]: *** [arch/ppc/boot/common] Error 2
make[1]: *** [zImage] Error 2
make: *** [_all] Error 2

Toolchain is built with crosstool

binutils-2.15
gcc-3.4.2
glibc-2.3.3

tglx
