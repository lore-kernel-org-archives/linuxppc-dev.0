Return-Path: <B29983@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
 [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 37549B6FF0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 14:45:37 +1100 (EST)
Received: from mail117-am1 (localhost [127.0.0.1])	by
 mail117-am1-R.bigfish.com (Postfix) with ESMTP id 5990C20301	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 03:45:29 +0000 (UTC)
Received: from AM1EHSMHS009.bigfish.com (unknown [10.3.201.247])	by
 mail117-am1.bigfish.com (Postfix) with ESMTP id 39B3E2C023E	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 03:45:29 +0000 (UTC)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: Add P1024rdb dts support
Date: Tue, 10 Jan 2012 03:45:13 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B02444B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1326098258-32097-1-git-send-email-b29983@freescale.com>
 <4F0B561A.7060903@freescale.com>
In-Reply-To: <4F0B561A.7060903@freescale.com>
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


> On 01/09/2012 02:37 AM, b29983@freescale.com wrote:
> > +/include/ "p1024rdb.dtsi"
> > +/include/ "fsl/p1020si-post.dtsi"
>=20
> Is p1024 100% software-compatible with p1020?
>=20
> They have different manuals...
>=20
> -Scott

P1020rdb has vitesse-7385 switch.
fsl/p1020si-post.dtsi can be used for both boards.

Regards,
Yuantian
