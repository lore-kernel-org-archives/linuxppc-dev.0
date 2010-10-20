Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 793ADB70CD
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 16:12:34 +1100 (EST)
Received: from mail54-tx2 (localhost.localdomain [127.0.0.1])	by
	mail54-tx2-R.bigfish.com (Postfix) with ESMTP id 984861203BE	for
	<linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 05:12:22 +0000 (UTC)
Received: from TX2EHSMHS013.bigfish.com (unknown [10.9.14.241])	by
	mail54-tx2.bigfish.com (Postfix) with ESMTP id E3F9C1918056	for
	<linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 05:12:19 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9K5CIQh024087	for <linuxppc-dev@ozlabs.org>;
	Tue, 19 Oct 2010 22:12:18 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o9K5CH5o020553	for <linuxppc-dev@ozlabs.org>;
	Wed, 20 Oct 2010 00:12:18 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt common to
	elbc devices
Date: Wed, 20 Oct 2010 13:12:20 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A2B08A5@zch01exm23.fsl.freescale.net>
In-Reply-To: <2D2A6B88-DA17-467D-BB43-919C1CAAB894@kernel.crashing.org>
References: <1287386552-10647-1-git-send-email-tie-fei.zang@freescale.com>
	<2D2A6B88-DA17-467D-BB43-919C1CAAB894@kernel.crashing.org>
From: Zang Roy-R61911 <r61911@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, October 19, 2010 21:19 PM
> To: Zang Roy-R61911
> Cc: linux-mtd@lists.infradead.org; Wood Scott-B07421;
dedekind1@gmail.com; Lan
> Chunhe-B25806; linuxppc-dev@ozlabs.org; akpm@linux-foundation.org;
> dwmw2@infradead.org; Gala Kumar-B11780
> Subject: Re: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt
common to
> elbc devices
>=20
>=20
> On Oct 18, 2010, at 2:22 AM, Roy Zang wrote:
>=20
> > Move Freescale elbc interrupt from nand dirver to elbc driver.
> > Then all elbc devices can use the interrupt instead of ONLY nand.
> >
> > For former nand driver, it had the two functions:
> >
> > 1. detecting nand flash partitions;
> > 2. registering elbc interrupt.
> >
> > Now, second function is removed to fsl_lbc.c.
> >
> > Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
> > Cc: Wood Scott-B07421 <B07421@freescale.com>
> > ---
>=20
> Roy, this is a nit, but are these really p4080 specific?  just
wondering why
> the subject is P4080/eLBC:...
We start these code in P4080 project. Some customer want to track eLBC
error on P4080, but some of the code is limited in nand driver only ...
That is why P4080/eLBC ...
Roy
