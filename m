Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 20830B6F06
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 13:31:02 +1000 (EST)
Received: from mail147-tx2 (localhost.localdomain [127.0.0.1])	by
	mail147-tx2-R.bigfish.com (Postfix) with ESMTP id 5013119202C5	for
	<linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 03:30:58 +0000 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.250])	by
	mail147-tx2.bigfish.com (Postfix) with ESMTP id 22707F700F2	for
	<linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 03:30:19 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o743UGct014904	for <linuxppc-dev@ozlabs.org>;
	Tue, 3 Aug 2010 20:30:16 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o743ULFN002086	for <linuxppc-dev@ozlabs.org>;
	Tue, 3 Aug 2010 22:30:22 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 2/3] P4080/mtd: Only make elbc nand driver detect nand
	flash partitions
Date: Wed, 4 Aug 2010 11:30:13 +0800
Message-ID: <83024545B35D6445A690EFD603E7869A07EFF7@zch01exm23.fsl.freescale.net>
In-Reply-To: <CB6DDAC6-620C-4FF1-B006-3E4F3E7A4E17@kernel.crashing.org>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, linuxppc-dev@ozlabs.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Tuesday, August 03, 2010 20:58 PM
> To: Zang Roy-R61911
> Cc: linuxppc-dev@ozlabs.org list; Lan Chunhe-B25806; Gala Kumar-B11780
> Subject: Re: [PATCH 2/3] P4080/mtd: Only make elbc nand=20
> driver detect nand flash partitions
>=20
>=20
> On Aug 2, 2010, at 11:45 PM, Roy Zang wrote:
>=20
> > From: Lan Chunhe-B25806 <b25806@freescale.com>
> >=20
> > The former driver had the two functions:
> >=20
> > 1. detecting nand flash partitions;
> > 2. registering elbc interrupt.
> >=20
> > Now, second function is removed to fsl_lbc.c.
> >=20
> > Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> > drivers/mtd/nand/Kconfig         |    1 +
> > drivers/mtd/nand/fsl_elbc_nand.c |  464=20
> ++++++++++++++------------------------
> > 2 files changed, 170 insertions(+), 295 deletions(-)
>=20
> mtd list and maintainer should be CC'd on these.
Make sense.
I will forward these patch to mtd list.
Thanks.
Roy
