Return-Path: <r66093@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
 [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 484F91007D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 14:14:30 +1100 (EST)
Received: from mail84-am1 (localhost [127.0.0.1])	by mail84-am1-R.bigfish.com
 (Postfix) with ESMTP id 7434940161	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2012 03:14:24 +0000 (UTC)
Received: from AM1EHSMHS010.bigfish.com (unknown [10.3.201.242])	by
 mail84-am1.bigfish.com (Postfix) with ESMTP id 5BD15280049	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 03:14:24 +0000 (UTC)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [PATCH] DTS: fix the bug and add the chip compatible for eSDHC
Date: Wed, 4 Jan 2012 03:14:20 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1165E585@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1324620659-7135-1-git-send-email-r66093@freescale.com>
 <CAOZdJXXXvTuJO_ZpyeRatWxTMbmcEVokA9qx7ajNdzKyiEgBhw@mail.gmail.com>
In-Reply-To: <CAOZdJXXXvTuJO_ZpyeRatWxTMbmcEVokA9qx7ajNdzKyiEgBhw@mail.gmail.com>
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



> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Tuesday, January 03, 2012 4:30 AM
> To: Huang Changming-R66093
> Cc: linuxppc-dev@lists.ozlabs.org; Huang Changming-R66093
> Subject: Re: [PATCH] DTS: fix the bug and add the chip compatible for
> eSDHC
>=20
> On Fri, Dec 23, 2011 at 12:10 AM,  <r66093@freescale.com> wrote:
> >
> > Accordint to latest kernel, the auto-cmd12 property should be
> > "sdhci,auto-cmd12", and according to the SDHC binding and the
> > workaround for the special chip, add the chip compatible for eSDHC:
> > "fsl,p1022-esdhc", "fsl,mpc8536-esdhc", "fsl,p2020-esdhc" and
> "fsl,p1010-esdhc".
>=20
> Please do not use the phrase "fix the bug" in patch summaries.
>=20
Then, could you tell me how to describe it?
