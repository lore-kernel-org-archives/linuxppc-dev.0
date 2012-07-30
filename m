Return-Path: <B04825@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FAFE2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 03:50:43 +1000 (EST)
Message-ID: <5016C8F9.7070801@freescale.com>
Date: Mon, 30 Jul 2012 12:48:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: <qiang.liu@freescale.com>
Subject: Re: [linuxppc-release] [PATCH v4 7/7] fsl-dma: add memcpy self test
 interface
References: <1343380616-12126-1-git-send-email-qiang.liu@freescale.com>
In-Reply-To: <1343380616-12126-1-git-send-email-qiang.liu@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Vinod Koul <vinod.koul@intel.com>,
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

qiang.liu@freescale.com wrote:
> 
> Add memory copy self test when probe device, fsl-dma will be disabled
> if self test failed.

Is this a real problem that can occur?  The DMA driver used to have a
self-test, but I removed it a long time ago because it was pointless.  I
don't see why we need to add another one back in.

-- 
Timur Tabi
Linux kernel developer at Freescale
