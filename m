Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BBD4DDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 01:51:07 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JMlc8-0008Im-93
	for linuxppc-embedded@ozlabs.org; Wed, 06 Feb 2008 06:51:04 -0800
Message-ID: <15306699.post@talk.nabble.com>
Date: Wed, 6 Feb 2008 06:51:04 -0800 (PST)
From: IngoM <ingo.maindorfer@ipm.fraunhofer.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [Virtex 4 PPC] Which Linux?
In-Reply-To: <20080205145834.GQ13945@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <15268468.post@talk.nabble.com>
	<20080205145834.GQ13945@pengutronix.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello!

Thanks for all answers!


Robert Schwebel wrote:
> 
> On Mon, Feb 04, 2008 at 05:54:55AM -0800, IngoM wrote:
>> 2) Linux
>> I'd like to build my kernel and filesystem myself. But which way to go?
>> Using OE, buildroot, ELDK...
>> Can you please provide some starting points for me?
> 
> ptxdist would be another alternative.
> 

In the meantime, I get crosstool to compile my toolchain.
With that toolchain I get a xilinx kernel from their git-repo compiling and
booting up.

ptxdist compiles my userland, but I have some more probs:

I use the xmd from EDK to download and run the kernel.
I try to setup a rootfs via NFS but the kernel didn't get an address, maybe
there is a problem with the network-setup.
It's not clear to me how put the kernel-image and the userland to one
elf-binary that is downloadable by xmd, because to work around the above
network issue to get things started.

Best Regards,

Ingo

-- 
View this message in context: http://www.nabble.com/-Virtex-4-PPC--Which-Linux--tp15268468p15306699.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
