Return-Path: <r58472@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13F3C2C01EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 12:51:51 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Vineeth <vneethv@gmail.com>, "linux-embedded@vger.kernel.org"
 <linux-embedded@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linuxppc-embedded@ozlabs.org"
 <linuxppc-embedded@ozlabs.org>, Wood Scott-B07421 <B07421@freescale.com>,
 "mporter@kernel.crashing.org" <mporter@kernel.crashing.org>
Subject: RE: rionet driver with MMIO DMA capability
Date: Fri, 6 Jul 2012 02:51:41 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F0934AA59@039-SN2MPN1-022.039d.mgd.msft.net>
References: <CAFbQSaDWXTg429q-tTRvcgAEsA1OmHzFVhPNOmSRnWjMpSZfpA@mail.gmail.com>
In-Reply-To: <CAFbQSaDWXTg429q-tTRvcgAEsA1OmHzFVhPNOmSRnWjMpSZfpA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
 "ranenikhil19@gmail.com" <ranenikhil19@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+leoli=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Vineeth
> Sent: Wednesday, July 04, 2012 1:16 AM
> To: linux-embedded@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> linuxppc-embedded@ozlabs.org; Wood Scott-B07421;
> mporter@kernel.crashing.org
> Cc: ranenikhil19@gmail.com
> Subject: rionet driver with MMIO DMA capability
>=20
>=20
> Hi,
>=20
> With kernel mainstream version 3.5.rc-5 there's SRIO low level driver
> with DMA support for MMIO. But the rionet driver in the same kernel
> version doesnt support MMIO.
>=20
> We are trying to find the maximum bandwidth that we can achieve using our
> custom board's(quad MPC8641 )=A0 4-lane SRIO.
> Now we are worried how to use this SRIO low level driver effectively ?
>=20
> The RIOnet driver (with 3.5.-rc5) uses message based communication. This
> doesnt use the DMA capability of low level driver. with this we are
> getting a bandwidth of nearly 900Mbps, which is very less.
>=20
> Is there any example code or modified middle ware driver for rionet/ or
> any code which uses the low level driver apis with MMIO DMA??

We provided the support for DMA in the old BSPs but didn't got the luck to =
make it upstream.  I heard Alex (CCed) is working on an upstream-able versi=
on of the feature.  Probably he can help to provide some code.

Leo
