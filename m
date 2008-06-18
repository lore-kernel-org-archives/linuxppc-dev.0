Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D74BBDDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jun 2008 23:32:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Anybody have an mpc5200b mscan linux driver under 2.6.24,
	ARCH=powerpc or equiv?
Date: Wed, 18 Jun 2008 06:32:14 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D6022FEAAE@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <48582CC6.60004@freescale.com>
References: <4858113F.4050203@vecimanetworks.com>
	<48582CC6.60004@freescale.com>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to wrestle the peak CAN driver for the old, non-device-tree
ppc into submission but I'm making a mess of it so far.

I think I'll get it going at some point, but if anybody has or knows of
an mscan driver for the mpc5200 can you alert me?

Thanks,
Mike

-----Original Message-----
From: linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org]
On Behalf Of Scott Wood
Sent: Tuesday, June 17, 2008 4:30 PM
To: Mike Winter
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PCI DMA Problems With 82xx?

Mike Winter wrote:
> We are developing with an 8248-based platform, and we have a vendor=20
> telling us that the PCI hardware is unreliable on this CPU family, in=20
> particular the DMA functionality.  A quick search of this list doesn't

> turn up any horror stories, although the processor does have some PCI=20
> errata listed.  Does anybody have any practical experience using PCI
on=20
> the 8248 or similar that they can share with me?   Thanks.

Make sure that you park the bus on PCI, and elevate PCI's arbitration=20
priority.  See fixup_pci() in arch/powerpc/boot/cuboot-pq2.c.

I haven't had a problem with PCI DMA when that is done, though I haven't

done significant stress testing.

-Scott
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
