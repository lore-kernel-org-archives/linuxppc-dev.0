Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id CDADE2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 04:33:28 +1000 (EST)
Date: Mon, 30 Jul 2012 11:33:23 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [linuxppc-release] [PATCH v4 7/7] fsl-dma: add memcpy self
 test interface
Message-ID: <20120730183322.GA32504@ovro.caltech.edu>
References: <1343380616-12126-1-git-send-email-qiang.liu@freescale.com>
 <5016C8F9.7070801@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5016C8F9.7070801@freescale.com>
Cc: Vinod Koul <vinod.koul@intel.com>, qiang.liu@freescale.com,
 herbert@gondor.hengli.com.au, linux-crypto@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2012 at 12:48:41PM -0500, Timur Tabi wrote:
> qiang.liu@freescale.com wrote:
> > 
> > Add memory copy self test when probe device, fsl-dma will be disabled
> > if self test failed.
> 
> Is this a real problem that can occur?  The DMA driver used to have a
> self-test, but I removed it a long time ago because it was pointless.  I
> don't see why we need to add another one back in.
> 
> -- 
> Timur Tabi
> Linux kernel developer at Freescale
> 

I made a comment that a test suite for the async_tx API would be very
helpful in diagnosing similar problems in this and other DMA drivers.
Something standalone, similar to the drivers/dma/dmatest.c driver, using
the async_tx API.

I think this was misinterpreted into me asking that the driver have a
built-in self test.

Ira
