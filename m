Return-Path: <B37400@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19A332C008A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 14:59:27 +1000 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [1/4] Device tree entry for Freescale TDM controller
Date: Mon, 1 Jul 2013 04:59:18 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E070D48EC@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
 <20130628221545.GA9357@home.buserror.net>
In-Reply-To: <20130628221545.GA9357@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: 29 June 2013 03:46
> To: Singh Sandeep-B37400
> Cc: linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> Aggrwal Poonam-B10812
> Subject: Re: [1/4] Device tree entry for Freescale TDM controller
>=20
> On Thu, Mar 07, 2013 at 04:57:45PM +0530, Sandeep Singh wrote:
> > +tdm@16000 {
> > +	compatible =3D "fsl,tdm1.0";
> > +	reg =3D <0x16000 0x200 0x2c000 0x2000>;
> > +	clock-frequency =3D <0>;
> > +	tdm_tx_clk =3D <2048000>;
> > +	interrupts =3D <62 8 0 0>;
> > +	fsl,max-time-slots =3D <128>;
> > +};
>=20
> tdm_tx_clk isn't in the binding (and should be named fsl,tdm-tx-clk if it
> is meant to be here at all).

I will add it in the binding.

Thanks,
Sandeep
>=20
> -Scott
