Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DCF6F2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 01:01:11 +1000 (EST)
Message-ID: <4FFD952D.8040201@freescale.com>
Date: Wed, 11 Jul 2012 10:01:01 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Qiang Liu <qiang.liu@freescale.com>
Subject: Re: [linuxppc-release] [PATCH v2 4/4] fsl-dma: use spin_lock_bh to
 instead of spin_lock_irqsave
References: <1341997326-18495-1-git-send-email-qiang.liu@freescale.com>
In-Reply-To: <1341997326-18495-1-git-send-email-qiang.liu@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Vinod Koul <vinod.koul@intel.com>, herbert@gondor.hengli.com.au,
 linux-crypto@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Qiang Liu wrote:
> Use spin_lock_bh to instead of spin_lock_irqsave for improving performance.

Please provide some evidence that performance has improved, as well as an
explanation why it's okay to use spin_lock_bh, and why it's faster.

-- 
Timur Tabi
Linux kernel developer at Freescale
