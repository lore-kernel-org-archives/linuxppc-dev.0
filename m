Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4D5F2C021B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 04:23:58 +1000 (EST)
Message-ID: <4FFF1633.1080308@freescale.com>
Date: Thu, 12 Jul 2012 13:23:47 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Liu Qiang-B32616 <B32616@freescale.com>
Subject: Re: [linuxppc-release] [PATCH v2 4/4] fsl-dma: use spin_lock_bh to
 instead of spin_lock_irqsave
References: <1341997326-18495-1-git-send-email-qiang.liu@freescale.com>
 <4FFD952D.8040201@freescale.com>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70C0987@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C0987@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
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

Liu Qiang-B32616 wrote:
> I compared my test result before and after this patch, write performance can
> improved by 15%. I will send the latest patches sooner because of Ira's concern.
> I will give a complete description about the improvement of spin_lock_bh().
> 
> About your question, spin_lock_bh is used in the case of bottom/half as its
> name, there is no need to protect a running/pending list with spin_lock_irqsave.

Please respin the patch and include this information in the patch description.

-- 
Timur Tabi
Linux kernel developer at Freescale
