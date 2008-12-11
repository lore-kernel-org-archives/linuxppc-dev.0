Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BB03DE027
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 13:16:03 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mBB2Fwpg008137
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:15:58 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mBB2FvwN007345
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 20:15:57 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] fsl-booke: declare tlbcam_index and num_tlbcam_entries
	for use in c file
Date: Thu, 11 Dec 2008 10:16:00 +0800
Message-ID: <D8176E55B81822498D63816C4ADC701027CD97@zch01exm26.fsl.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0812100602210.28806@t2.domain.actdsltmp>
References: <1228898473-29986-1-git-send-email-yu.liu@freescale.com>
	<Pine.LNX.4.64.0812100602210.28806@t2.domain.actdsltmp>
From: "Liu Yu" <Yu.Liu@freescale.com>
To: "Piepho Trent-B16872" <tpiepho@freescale.com>
Cc: Wood Scott-B07421 <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Gala Kumar-B11780 <kumar.gala@freescale.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Piepho Trent-B16872=20
> Sent: Wednesday, December 10, 2008 10:04 PM
> To: Liu Yu-B13201
> Cc: linuxppc-dev@ozlabs.org; kvm-ppc@vger.kernel.org; Wood=20
> Scott-B07421; Gala Kumar-B11780
> Subject: Re: [PATCH] fsl-booke: declare tlbcam_index and=20
> num_tlbcam_entries for use in c file
>=20
> On Wed, 10 Dec 2008, Liu Yu wrote:
> > KVM on E500 platform currently utilize TLB1 entries without=20
> bothering host,
> > that is using unused TLB1 entries.
> >
> > So, KVM needs to read tlbcam_index and num_tlbcam_entries=20
> to know exactly
> > which TLB1 entry is unused.
>=20
> Do you need really need num_tlbcam_entries?  It's completely=20
> unused and
> I've already sent out a patch to remove it.  If you want to know how
> big TLB1 is, just read it from SPRN_TLB1CFG.
>=20

Ah, I missed your patch.
Certainly I can use SPRN_TLB1CFG.
I thought if kernel provide a way to get it, then I would rather get it
from kernel than from hardware.
