Return-Path: <B32616@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F5672C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 12:47:35 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>, Tabi Timur-B04825
 <B04825@freescale.com>
Subject: RE: [linuxppc-release] [PATCH v4 7/7] fsl-dma: add memcpy self test
 interface
Date: Tue, 31 Jul 2012 02:47:26 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C5C8E@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1343380616-12126-1-git-send-email-qiang.liu@freescale.com>
 <5016C8F9.7070801@freescale.com> <20120730183322.GA32504@ovro.caltech.edu>
In-Reply-To: <20120730183322.GA32504@ovro.caltech.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>, Vinod Koul <vinod.koul@intel.com>,
 "herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linux-crypto-owner@vger.kernel.org [mailto:linux-crypto-
> owner@vger.kernel.org] On Behalf Of Ira W. Snyder
> Sent: Tuesday, July 31, 2012 2:33 AM
> To: Tabi Timur-B04825
> Cc: Liu Qiang-B32616; linux-crypto@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Vinod Koul; herbert@gondor.hengli.com.au; Dan
> Williams; Li Yang-R58472; davem@davemloft.net
> Subject: Re: [linuxppc-release] [PATCH v4 7/7] fsl-dma: add memcpy self
> test interface
>=20
> On Mon, Jul 30, 2012 at 12:48:41PM -0500, Timur Tabi wrote:
> > qiang.liu@freescale.com wrote:
> > >
> > > Add memory copy self test when probe device, fsl-dma will be disabled
> > > if self test failed.
> >
> > Is this a real problem that can occur?  The DMA driver used to have a
> > self-test, but I removed it a long time ago because it was pointless.
> I
> > don't see why we need to add another one back in.
> >
> > --
> > Timur Tabi
> > Linux kernel developer at Freescale
> >
>=20
> I made a comment that a test suite for the async_tx API would be very
> helpful in diagnosing similar problems in this and other DMA drivers.
> Something standalone, similar to the drivers/dma/dmatest.c driver, using
> the async_tx API.
>=20
> I think this was misinterpreted into me asking that the driver have a
> built-in self test.
I will drop it in next version. Thanks.

>=20
> Ira
> --
> To unsubscribe from this list: send the line "unsubscribe linux-crypto"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
