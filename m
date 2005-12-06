Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id 9DA5368883
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 05:02:44 +1100 (EST)
Received: from White64 (p54B4B9F1.dip0.t-ipconnect.de [84.180.185.241])
	(authenticated)
	by aphrodite.net-build.de (8.11.6/8.11.2) with ESMTP id jB6H0gM26206
	for <linuxppc-embedded@ozlabs.org>; Tue, 6 Dec 2005 18:00:53 +0100
Date: Tue, 6 Dec 2005 17:58:38 +0100
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051206175838.2c2e0f82@White64>
In-Reply-To: <20051206164212.82779.qmail@web33505.mail.mud.yahoo.com>
References: <20051206164212.82779.qmail@web33505.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: Denx vs kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Tue, 6 Dec 2005 08:42:12 -0800 (PST) schrieb Matt Jerdonek
<maj1224@yahoo.com> :

Hello
> I'm looking at embedding linux into a PowerPC-based
> system.  I found the DENX website to be very helpful,
> but I'm struggling to understand a few items:
Welcome to our Club :)

> 
> 1) The source from kernel.org appears to have support
> for the powerpc (arch/powerpc/8xx_io).  But when using
> 'make xconfig' I cannot select PowerPC from the list
> of processors.  Is this just a limitation on the the
> configuration utility?
Try setting ARCH=ppc or so...
make ARCH=ppc CROSS_COMPILE=xxx  menuconfig uImage and so on

> 
> 2) What is the difference between the sources on DENX
> and kernel.org?  Are there other places where PPC
> linux kernel source is stored?  I'm not opposed to
> using the DENX source, I'm just trying to understand
> it.
> 

The Kernel Source is tested and released from many Developers.
The Denx Kernel is a kind of specialized.

Some parts are missing, some special patches aare in this Kernel,
the Mainstream Kernel developer dont want to add.

There are Other Sources too. 

Google or some Docu Site fpr ppc linux can help.

> 3) I've used eCos before and I'm familiar with
> RedBoot.  Is there a compelling reason to use U-Boot
> over RedBoot?  For example, I think U-boot contains an
> NFS client while RedBoot does not.  Is this important?

i'm booting the kernel in uboot over tftp.
You dont need nfs in u-boot...

i dont know redboot, but in uboot you can do many diagnostoc or
maintaining work at the Console.

Its easy to extend by special needs and support a lot of platforms.



> 
> Thanks in advance,
> -- Matt


Good luck...
