Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0143.outbound.protection.outlook.com [157.56.110.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80B1D1A0A06
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 15:05:05 +1100 (AEDT)
Message-ID: <1417665891.15957.238.camel@freescale.com>
Subject: Re: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch
 warning"
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Wed, 3 Dec 2014 22:04:51 -0600
In-Reply-To: <1417596833-31456-2-git-send-email-haokexin@gmail.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
 <1417596833-31456-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Yuantian Tang <Yuantian.Tang@freescale.com>,
 Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-03 at 16:53 +0800, Kevin Hao wrote:
> This reverts commit da788acb28386aa896224e784954bb73c99ff26c.
> 
> That commit tried to fix the section mismatch warning by moving the
> ppc_corenet_clk_driver struct to init section. This is definitely wrong
> because the kernel would free the memories occupied by this struct
> after boot while this driver is still registered in the driver core.
> The kernel would panic when accessing this driver struct.
> 
> Cc: stable@vger.kernel.org # 3.17

I don't see stable@vger.kernel.org in the actual CC list.

-Scott
