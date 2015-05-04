Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 316711A0602
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 07:49:58 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH 1/2] sdhci-of-esdhc: Support 8BIT bus width.
Date: Mon, 4 May 2015 21:49:54 +0000
Message-ID: <1430776194.27859.64.camel@transmode.se>
References: <1430757092-15847-1-git-send-email-joakim.tjernlund@transmode.se>
 <2384804.XbcbTBBFP9@wuerfel> <1430774247.27859.62.camel@transmode.se>
In-Reply-To: <1430774247.27859.62.camel@transmode.se>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-05-04 at 21:17 +0000, Joakim Tjernlund wrote:
> On Mon, 2015-05-04 at 19:31 +0200, Arnd Bergmann wrote:
> > On Monday 04 May 2015 18:31:31 Joakim Tjernlund wrote:
> > > @@ -252,6 +260,8 @@ static void esdhc_of_platform_init(struct sdhci_h=
ost *host)
> > > =20
> > >         if (vvn > VENDOR_V_22)
> > >                 host->quirks &=3D ~SDHCI_QUIRK_NO_BUSY_IRQ;
> > > +
> > > +       host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> > >  }
> > >=20
> >=20
> > Shouldn't this check the "bus-width" property before setting the width?
> >=20
> > There might be an eMMC or SDIO with 4-bit interface connected.
>=20
> This is for an eMMC chip we got and I THINK(this is new to me) that
> this only allows 8 bit negotiation but I might be way off.
> =20
> Anyone knows for sure?

hmm, I need to look some more at this. There is bus-with/8BIT all over mmc =
and I
have probably missed something.

       Jocke
