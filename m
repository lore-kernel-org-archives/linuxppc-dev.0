Return-Path: <rwoodworth@securics.com>
Received: from securics.com (unknown [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 8A542DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 03:26:59 +1000 (EST)
Subject: Re: Xilinx Virtex4 FX PPC
From: Robert Woodworth <rwoodworth@securics.com>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
In-Reply-To: <20070820113549.7cc3ac45@weaponx.rchland.ibm.com>
References: <1187625654.6336.28.camel@PisteOff>
	<20070820113549.7cc3ac45@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 20 Aug 2007 11:26:57 -0600
Message-Id: <1187630817.6336.34.camel@PisteOff>
Mime-Version: 1.0
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

On Mon, 2007-08-20 at 11:35 -0500, Josh Boyer wrote:
> On Mon, 20 Aug 2007 10:00:54 -0600
> Robert Woodworth <rwoodworth@securics.com> wrote:
> 
> > Problem 2:  Build my own rootfs.
> > If I try to build my own programs (busybox and bash at this point) with
> > shared libc using the same glibc from my toolchain, I get an "Illegal
> > instruction" error.  Is my glibc not compatible with my Xilinx PPC 405??
> > 
> > 
> > If I try to build a rootfs with debian ppc packages I have the same
> > "Illegal instruction" error.
> > 
> > 
> > 
> > Question 1:
> > Do I need a special glibc for the Xilinx PPC 405????  
> > Does a normal PPC glibc have more "advanced" instructions compiled in
> > that will not work on a Xilinx PPC 405??
> 
> Make sure you're building glibc with soft-fp, or make sure you have
> CONFIG_MATH_EMULATION enabled in your kernel.  The PPC 405 doesn't have
> an FPU.
> 
> josh


CONFIG_MATH_EMULATION fixed it!!



What are the opinions out there? 
Kernel fp or glibc soft-fp??

I don't have a need for floating point in my final application anyway.
