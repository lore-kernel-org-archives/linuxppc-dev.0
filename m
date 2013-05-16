Return-Path: <r61911@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9AFC72C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 15:59:29 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: SATA FSL and upstreaming
Date: Thu, 16 May 2013 05:59:05 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B1E03C8@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
In-Reply-To: <1368683156.9603.34.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For PCIe issue, I might be related to your RCW (Reset Configuration Word).
Can you help to provide the u-boot log?
Roy

> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> fei.zang=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Benjamin
> Herrenschmidt
> Sent: Thursday, May 16, 2013 1:46 PM
> To: Liu Qiang-B32616
> Cc: linuxppc-dev@lists.ozlabs.org; Fleming Andy-AFLEMING; Xie Shaohui-
> B21989
> Subject: Re: SATA FSL and upstreaming
>=20
> On Thu, 2013-05-16 at 14:47 +1000, Benjamin Herrenschmidt wrote:
> > Hi folks !
> >
> > So I was trying to use my 5020ds to test some stuff today. Since I
> > hadn't used it in a while, I decided to "upgrade" it to the latest NOR
> > etc...
>=20
> On another note, I can't seem to get any PCIe card recognized in any
> slot...
>=20
> Can you give me an example config of the DIP switches that is known to
> work with some slots ? Is there some EEPROM config needed ? If yes, any
> pointers ? (I can't quite make sense of either u-boot or the doc there).
>=20
> Thanks,
> Ben.
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
