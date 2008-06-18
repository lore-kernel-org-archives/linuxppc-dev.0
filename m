Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0AEC0DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jun 2008 00:02:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Anybody have an mpc5200b mscan linux driver under 2.6.24,
	ARCH=powerpc or equiv?
Date: Wed, 18 Jun 2008 07:02:32 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D6022FEAC0@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <48591167.1050303@grandegger.com>
References: <4858113F.4050203@vecimanetworks.com>	<48582CC6.60004@freescale.com>
	<161B3BAD77161449A144FF054231C3D6022FEAAE@uss-am-xch-01.am.trimblecorp.net>
	<48591167.1050303@grandegger.com>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: "Wolfgang Grandegger" <wg@grandegger.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the quick response. I'm currently using 2.6.24 ARCH=3Dpowerpc
on the Lite5200b. I just searched for an obvious patch but it is unclear
to me what patch(es) I should take at this point.

Can you direct me to the patch(es) I need? Again, thank you.

-Mike=20

-----Original Message-----
From: Wolfgang Grandegger [mailto:wg@grandegger.com]=20
Sent: Wednesday, June 18, 2008 8:45 AM
To: Mike Timmons
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Anybody have an mpc5200b mscan linux driver under 2.6.24,
ARCH=3Dpowerpc or equiv?

Mike Timmons wrote:
> I'm trying to wrestle the peak CAN driver for the old, non-device-tree
> ppc into submission but I'm making a mess of it so far.
>=20
> I think I'll get it going at some point, but if anybody has or knows
of
> an mscan driver for the mpc5200 can you alert me?

http://svn.berlios.de/svnroot/repos/socketcan/trunk/README

The Socket-CAN core is part of the official kernel since 2.6.25.

Wolfgang.

>=20
> Thanks,
> Mike
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org
> =
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org]
> On Behalf Of Scott Wood
> Sent: Tuesday, June 17, 2008 4:30 PM
> To: Mike Winter
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: PCI DMA Problems With 82xx?
>=20
> Mike Winter wrote:
>> We are developing with an 8248-based platform, and we have a vendor=20
>> telling us that the PCI hardware is unreliable on this CPU family, in

>> particular the DMA functionality.  A quick search of this list
doesn't
>=20
>> turn up any horror stories, although the processor does have some PCI

>> errata listed.  Does anybody have any practical experience using PCI
> on=20
>> the 8248 or similar that they can share with me?   Thanks.
>=20
> Make sure that you park the bus on PCI, and elevate PCI's arbitration=20
> priority.  See fixup_pci() in arch/powerpc/boot/cuboot-pq2.c.
>=20
> I haven't had a problem with PCI DMA when that is done, though I
haven't
>=20
> done significant stress testing.
>=20
> -Scott
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
