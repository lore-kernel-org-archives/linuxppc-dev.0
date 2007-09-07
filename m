Return-Path: <MBenedict@twacs.com>
Received: from outbound4-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D1290DDECC
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Sep 2007 07:32:28 +1000 (EST)
Received: from outbound4-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-blu-R.bigfish.com (Postfix) with ESMTP id CF33F1FB87B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 21:16:54 +0000 (UTC)
Received: from mail187-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound4-blu.bigfish.com (Postfix) with ESMTP id A119016004C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 21:16:54 +0000 (UTC)
Received: from mail187-blu (localhost.localdomain [127.0.0.1])
	by mail187-blu-R.bigfish.com (Postfix) with ESMTP id 5E4D3DE01C3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 21:16:54 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail187-blu.bigfish.com (Postfix) with ESMTP id 1D476174809A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 21:16:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: random panic and freezes on mpc8349 itx
Date: Fri, 7 Sep 2007 16:16:35 -0500
Message-ID: <BAF8B1E0BB28024A90895E746A3B610D1C2BDF@twx-exch01.twacs.local>
In-Reply-To: <200709071405.06500.nschichan@freebox.fr>
References: <200709071405.06500.nschichan@freebox.fr>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What version of U-boot are you using?  Could it be RAM initialization?
There was a RAM initialization bug in the ITX for u-boot git sources
until April 2007.
	Good luck,
		Michael

linuxppc-embedded-bounces+mbenedict=3Dtwacs.com@ozlabs.org wrote:
> Hi,
>=20
> I am currently working with an MPC8349ITX board and I have
> some trouble with
> the kernel as soon as it reaches userland.
>=20
> If I boot the kernel with all the memory (256MB) available (no
> mem=3D... on the command line), I get random freezes or random kernel
> panics.=20
> Some times it
> won't even run init. Some times it will panic badly if I try
> to put some
> pressure to the system (stress --cpu 256). Some times it will hang
> immediately after logging in, ...
>=20
> If I boot the kernel with mem=3D64M, these freeze and random
> panic disapear and
> I am able to run the stress program without any problems.
>=20
> I have had this strange behaviour on both kernel 2.6.20 and
> 2.6.22 with
> mpc834x_itx_defconfig (both from kernel.org) (ARCH=3Dpowerpc).
>=20
> I am inclined to say that it is not a broken RAM chip problem because
> if I use a 2.6.17 from kernel.org with all the RAM available
> (ARCH=3Dppc) configured with mpc834x_sys_defconfig (there was no
> defconfig for the=20
> itx board on this
> version) everything runs fine and I am able to run the stress program
> without any problems.
>=20
> The panic does not happen very often, 90% of the time, the
> board hangs and
> stops responding to ping. When a panic do happen it is almost always
> in a different place.
>=20
> Does any of you have met this problem before ? If you have
> any clues about
> what is hapenning I'd be glad to hear about it :)
>=20
> Thank you for your attention,
>=20
> Regards,
