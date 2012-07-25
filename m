Return-Path: <r61911@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15EBB2C008E
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 12:55:23 +1000 (EST)
Received: from mail151-va3 (localhost [127.0.0.1])	by
 mail151-va3-R.bigfish.com (Postfix) with ESMTP id C76673A0075	for
 <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 02:55:20 +0000 (UTC)
Received: from VA3EHSMHS042.bigfish.com (unknown [10.7.14.240])	by
 mail151-va3.bigfish.com (Postfix) with ESMTP id A4E74200C6	for
 <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 02:55:18 +0000 (UTC)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Tabi Timur-B04825
 <B04825@freescale.com>
Subject: RE: [PATCH] powerpc/p5040ds: Add support for P5040DS board
Date: Wed, 25 Jul 2012 02:55:14 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB002079C5944@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com> <500EE4C3.40707@freescale.com>
 <500EEA46.6030807@freescale.com>
In-Reply-To: <500EEA46.6030807@freescale.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> fei.zang=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Scott Wood
> Sent: Wednesday, July 25, 2012 2:33 AM
> To: Tabi Timur-B04825
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
>=20
> On 07/24/2012 01:09 PM, Timur Tabi wrote:
> > Scott Wood wrote:
> >> On 07/24/2012 11:42 AM, Timur Tabi wrote:
> >>> +/* controller at 0x200000 */
> >>> +&pci0 {
> >>> +	compatible =3D "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.2";
> >>
> >> p5040 has PCIe v2.4.
> >
> > Then it's broken on the SDK as well.
>=20
> Yes.  There was internal discussion about this over the last few days.
In SDK, we use consist v2.2, so there is no obvious problem, but we need to=
 fix this to v2.4. P5020 PCIe adds Liodn registers.
Roy
