Return-Path: <r61911@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 839682C0098
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 14:45:52 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Timur Tabi
 <timur@tabi.org>
Subject: RE: SATA FSL and upstreaming
Date: Fri, 7 Jun 2013 04:45:15 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B2135A0@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <1368687133.9603.51.camel@pasglop>
 <CAOZdJXU79kqEGk_nqv1NSzna7c=bgwSv+6WFgaTVjR4Rj4cZVg@mail.gmail.com>
 <1370577138.3766.342.camel@pasglop> <1370579976.3766.345.camel@pasglop>
In-Reply-To: <1370579976.3766.345.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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
> fei.zang=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Benjamin
> Herrenschmidt
> Sent: Friday, June 07, 2013 12:40 PM
> To: Timur Tabi
> Cc: Xie Shaohui-B21989; Liu Qiang-B32616; Zang Roy-R61911; tiejun.chen;
> Fleming Andy-AFLEMING; Bhushan Bharat-R65777; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: SATA FSL and upstreaming
>=20
> On Fri, 2013-06-07 at 13:52 +1000, Benjamin Herrenschmidt wrote:
>=20
> > So I got the rev2 chip today, put it in, and PCI-E is still not
> > getting a link. Since the LEDs of the e1000 aren't coming up at all, I
> > *suspect* the slots are getting no power.
> >
> > Is there a power control somewhere ? Maybe some DIP or jumpers that
> > might have gone off ?
>=20
> Forget it, reset all the jumpers to the default setup (found the doc !)
> and they come up now in slot 4 and 7. It also looks like uBoot now has an
> e1000 driver so I don't have to use fman (for which I believe there is
> still no upstream driver right ?)
fman in u-boot has been up streamed.  It should work.
>=20
> BTW. Is that normal during boot ?
>=20
> Net:   Initializing Fman
> Fman1: Uploading microcode version 106.1.7 PHY reset timed out PHY reset
> timed out PHY reset timed out PHY reset timed out
You can ignore the timeout.=20
Do you plug other card (for example SGMII card) on the board?
u-boot detects some card in the slot and tries to init the PHY but fails.
Roy
