Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 49F3467A7A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Feb 2005 02:59:08 +1100 (EST)
Date: Sun, 27 Feb 2005 08:59:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Message-ID: <20050227085905.A11020@cox.net>
References: <200502262328.24165.niklaus.giger@member.fsf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200502262328.24165.niklaus.giger@member.fsf.org>;
	from niklaus.giger@member.fsf.org on Sat, Feb 26, 2005 at
	11:28:23PM +0100
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problems porting to a custom PPC405GPr board using a vanilla
	2.6.10 kernel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Feb 26, 2005 at 11:28:23PM +0100, Niklaus Giger wrote:
> Hi
> 
> I would like to port Linux to a custom PPC405GPr board. Its hardware runs 
> vxWorks fine for more than a year. 

Good, gives a good feeling about the hardware.
 
> My board has no RTC. Is this a problem? 

No, not at all.

> Should I start with another kernel? Can anybody point me to a known good 
> kernel version for a specific PPC405 board?

The stock kernel.org 2.6.10 that you seem to be using is fine.
 
> Any hint would be greatly appreciated.

Working out your BDI issues will be very helpful to debugging. It's
only clear that it passes beyond setup_arch() at this point. That's
good, though.

-Matt
