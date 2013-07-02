Return-Path: <B42677@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F0D2C2C02BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 18:00:54 +1000 (EST)
From: Zhang Haijun-B42677 <B42677@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] DTS: Add compatible list for eSDHC
Date: Tue, 2 Jul 2013 08:00:43 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E13609E1@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1372656110-13876-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Mon Jul  1 00:21:50 2013)
 <1372723475.8183.100@snotra>
In-Reply-To: <1372723475.8183.100@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>




Regards
Haijun.

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, July 02, 2013 8:05 AM
> To: Zhang Haijun-B42677
> Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; Zhang
> Haijun-B42677; Fleming Andy-AFLEMING
> Subject: Re: [PATCH] DTS: Add compatible list for eSDHC
>=20
> On 07/01/2013 12:21:50 AM, Haijun Zhang wrote:
> > Add compatible of esdhc for below board:
> > p2041   p3041   p4080   p5020   p5040
> >
> > Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> > CC: Scott Wood <scottwood@freescale.com>
> > CC: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
> > arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
> > arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
> > arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
> > arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
> >  5 files changed, 5 insertions(+)
>=20
> Is there something specific that depends on this, or are you just trying
> to conform to other examples?
>=20
> I don't think we need the SoC name here, given that eSDHC has a version
> register that you can read (and an SVR in the unlikely case that that
> isn't adequate).  If you did end up relying on this device tree change,
> you'd be broken if an older device trees is used.
>=20
[Haijun Wrote:] Yes, in mmc driver (sdhci-pltfm.c)some quirks depends on So=
c name and its Soc version (sdhci-of-esdhc.c), even if they had the same eS=
DHC version.

> -Scott
