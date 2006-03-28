Return-Path: <hollis@penguinppc.org>
Received: from elasmtp-banded.atl.sa.earthlink.net
	(elasmtp-banded.atl.sa.earthlink.net [209.86.89.70])
	by ozlabs.org (Postfix) with ESMTP id 65FC167A0E
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 14:43:09 +1100 (EST)
Received: from [63.246.184.80] (helo=[192.168.0.100])
	by elasmtp-banded.atl.sa.earthlink.net with asmtp (Exim 4.34)
	id 1FO56o-0007te-Nx
	for linuxppc-dev@ozlabs.org; Mon, 27 Mar 2006 22:43:06 -0500
Mime-Version: 1.0 (Apple Message framework v623)
In-Reply-To: <200603261956.40700.bcook@bpointsys.com>
References: <OF06763F9B.91995CDB-ON4825713E.000850DE-4825713E.000949FE@cn.ibm.com>
	<200603261956.40700.bcook@bpointsys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f78eb6c06abb98fbc1cf8ae32bbf2268@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: make install on ppc
Date: Mon, 27 Mar 2006 21:43:16 -0600
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mar 26, 2006, at 7:56 PM, Brent Cook wrote:

> On Sunday 26 March 2006 19:42, Jin Qi Huang wrote:
>> I also think the 'make install' is very useful, now on ia32, the 'make
>> install' provided by the latest kernel linux-2.6.16 not only create
>> initrd, copy vmlinuz and System.map to /boot directory, but also 
>> update
>> grub, ppc32 does not provide this useful feature, maybe it is a pity!

The feature sounds like a good idea to me, even if it's just the 
copying files part. Do any PPC distros provide a working installkernel 
script?

> Maybe narrow it to define 'make install' for new world/old world 
> Macintoshes,
> or IBM machines? I can't see a generic make install being useful for 
> the
> wider range of platforms that fall under ppc.
>
> 'make install' appears to me to be very platform dependent. Sure, on 
> x86, you
> can reasonably assume that the majority of systems have the kernel on 
> a disk
> under /boot and the bootloader is grub or lilo. I have 5 ppc machines
> currently, and no two use the same bootloader or kernel image. I've 
> seen
> u-boot, yaboot, quik, powerboot (Motorola/Force), xmon (XES) and more, 
> and
> they all required different post-processing to the kernel image to 
> boot. For
> most of these, there is no way to programmatically guess where a 
> particular
> kernel image should go to work with the boot loader.

If you have an unusual platform, don't run make install and you have 
lost nothing... :)

-Hollis
