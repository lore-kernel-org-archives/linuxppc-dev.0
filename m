Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E146B70D5
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 17:38:06 +1100 (EST)
Received: from mail134-tx2 (localhost.localdomain [127.0.0.1])	by
	mail134-tx2-R.bigfish.com (Postfix) with ESMTP id B19334801C6	for
	<linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 06:37:48 +0000 (UTC)
Received: from TX2EHSMHS046.bigfish.com (unknown [10.9.14.244])	by
	mail134-tx2.bigfish.com (Postfix) with ESMTP id 8E50EA78046	for
	<linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 06:37:48 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9J6bk6J020255	for
	<linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 23:37:46 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o9J6r5MO029827	for <linuxppc-dev@ozlabs.org>;
	Tue, 19 Oct 2010 01:53:06 -0500 (CDT)
Subject: RE: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt common to
	elbc	devices
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 19 Oct 2010 14:37:56 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A2B07BC@zch01exm23.fsl.freescale.net>
In-Reply-To: <20101018110631.22d6f081@udp111988uds.am.freescale.net>
References: <1287386552-10647-1-git-send-email-tie-fei.zang@freescale.com><4CBC0B95.9010300@windriver.com>
	<20101018110631.22d6f081@udp111988uds.am.freescale.net>
From: Zang Roy-R61911 <r61911@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, tiejun.chen
	<tiejun.chen@windriver.com>
Cc: dedekind1@gmail.com, Lan Chunhe-B25806 <B25806@freescale.com>,
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
> From: Wood Scott-B07421
> Sent: Tuesday, October 19, 2010 0:07 AM
> To: tiejun.chen
> Cc: Zang Roy-R61911; linux-mtd@lists.infradead.org; Wood Scott-B07421;
> dedekind1@gmail.com; Lan Chunhe-B25806; linuxppc-dev@ozlabs.org;
akpm@linux-
> foundation.org; dwmw2@infradead.org; Gala Kumar-B11780
> Subject: Re: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt
common to
> elbc devices
>=20
> On Mon, 18 Oct 2010 16:55:49 +0800
> "tiejun.chen" <tiejun.chen@windriver.com> wrote:
>=20
> > Looks you always iounmap(fsl_lbc_ctrl_dev->regs) on position 'err'
but here
> > of_iomap() is already failed you should skip iounmap()
fsl_lbc_ctrl_dev-
> >regs
> > again. So you should improve that as the following on 'err', or
layout 'err'
> in
> > gain.
> > ------
> > 	if(fsl_lbc_ctrl_dev->regs)
> > 		iounmap(fsl_lbc_ctrl_dev->regs);
> >
>=20
> It looks like iounmap(NULL) is a no-op, just like kfree(NULL).
Thanks for the reminder. I will keep original post, if there is no more
comment.
Roy
