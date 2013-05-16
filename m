Return-Path: <r61911@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB9032C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 17:17:22 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: SATA FSL and upstreaming
Date: Thu, 16 May 2013 07:17:12 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B1E0770@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E056D@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368687558.9603.54.camel@pasglop>
In-Reply-To: <1368687558.9603.54.camel@pasglop>
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
> Sent: Thursday, May 16, 2013 2:59 PM
> To: Zang Roy-R61911
> Cc: Xie Shaohui-B21989; Liu Qiang-B32616; tiejun.chen; Fleming Andy-
> AFLEMING; Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org
> Subject: Re: SATA FSL and upstreaming
>=20
> Ok, so I found this one on the SDK ISO: rcw_15g_2000mhz.bin
>=20
> I flashed that, did pix altbank, I'm now booted from Bank 4 ... and PCIe
> is still showing nothing. I have cards in slots 4 and 7 (assuming that's
> the right numbering, ie, 7 is the top one).
Right.
>=20
> Are we sure we don't have a problem with some DIP ? I saw some of them
> control some SERDES stuff (SW5 iirc)
Your serdes1 clock is 100MHz,which is correct.
Slot7 (PCIe1) does not need extra DIP to make it work.
Maybe you also need to update the U-boot.
Roy
