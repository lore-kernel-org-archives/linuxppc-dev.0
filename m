Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F9DD2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 00:25:29 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Liu Qiang-B32616 <B32616@freescale.com>
Subject: Re: [linuxppc-release] [PATCH v3 4/4] fsl-dma: use spin_lock_bh to
 instead of spin_lock_irqsave
Date: Mon, 16 Jul 2012 14:25:18 +0000
Message-ID: <5004244D.4000106@freescale.com>
References: <1342411780-29930-1-git-send-email-qiang.liu@freescale.com>
In-Reply-To: <1342411780-29930-1-git-send-email-qiang.liu@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
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

Qiang Liu wrote:
> Use spin_lock_bh to instead of spin_lock_irqsave for improving performanc=
e.

You forgot to include the evidence that performance has improved, as well=20
as an explanation why it's okay to use spin_lock_bh, and why it's faster.=20
  I told you to respin the patch with that information in the patch=20
description.

--=20
Timur Tabi
Linux kernel developer at Freescale
