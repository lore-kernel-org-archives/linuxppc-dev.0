Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2188DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 02:36:11 +1000 (EST)
Date: Mon, 20 Aug 2007 11:35:49 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Robert Woodworth <rwoodworth@securics.com>
Subject: Re: Xilinx Virtex4 FX PPC
Message-ID: <20070820113549.7cc3ac45@weaponx.rchland.ibm.com>
In-Reply-To: <1187625654.6336.28.camel@PisteOff>
References: <1187625654.6336.28.camel@PisteOff>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 20 Aug 2007 10:00:54 -0600
Robert Woodworth <rwoodworth@securics.com> wrote:

> Problem 2:  Build my own rootfs.
> If I try to build my own programs (busybox and bash at this point) with
> shared libc using the same glibc from my toolchain, I get an "Illegal
> instruction" error.  Is my glibc not compatible with my Xilinx PPC 405??
> 
> 
> If I try to build a rootfs with debian ppc packages I have the same
> "Illegal instruction" error.
> 
> 
> 
> Question 1:
> Do I need a special glibc for the Xilinx PPC 405????  
> Does a normal PPC glibc have more "advanced" instructions compiled in
> that will not work on a Xilinx PPC 405??

Make sure you're building glibc with soft-fp, or make sure you have
CONFIG_MATH_EMULATION enabled in your kernel.  The PPC 405 doesn't have
an FPU.

josh
