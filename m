Return-Path: <B29983@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 90652B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 13:41:55 +1100 (EST)
Received: from mail14-am1 (localhost [127.0.0.1])	by mail14-am1-R.bigfish.com
 (Postfix) with ESMTP id C412F34011D	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 11 Jan 2012 02:41:48 +0000 (UTC)
Received: from AM1EHSMHS004.bigfish.com (unknown [10.3.201.249])	by
 mail14-am1.bigfish.com (Postfix) with ESMTP id A516A640043	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 02:41:48 +0000 (UTC)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: Add P1024rdb dts support
Date: Wed, 11 Jan 2012 02:41:46 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B024805@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1326098258-32097-1-git-send-email-b29983@freescale.com>
 <4F0B561A.7060903@freescale.com>
 <D07C73A334FF604B95B3CBD2A545D07B02444B@039-SN2MPN1-013.039d.mgd.msft.net>
 <4F0C7928.1020803@freescale.com>
In-Reply-To: <4F0C7928.1020803@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> >
> > P1020rdb has vitesse-7385 switch.
>=20
> I'm talking about the SoC, not the board.
>=20
> > fsl/p1020si-post.dtsi can be used for both boards.
>=20
> What are you basing this on?  Has someone looked over both manuals in
> detail and concluded that every device described is 100% compatible?
>=20

I ported this from the dts in kernel 2.6.35.=20
I found they are 100% compatible from dts point of view.

Regards,
Yuantian
