Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0109.outbound.protection.outlook.com [157.56.110.109])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2DBE1A004A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 23:13:12 +1000 (EST)
Message-ID: <542410D3.2060507@freescale.com>
Date: Thu, 25 Sep 2014 15:55:47 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: Jingchang Lu <jingchang.lu@freescale.com>, <mturquette@linaro.org>
Subject: Re: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
References: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
In-Reply-To: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jingchang,

On 09/23/2014 09:46 AM, Jingchang Lu wrote:
> The IP is shared by PPC and ARM, this renames it to qoriq for better
> represention, and this also adds the CLK_OF_DECLARE support for being
> initialized by of_clk_init() on ARM.
> 

I think you need to also update drivers/cpufreq/Kconfig.powerpc
to use the renamed config option.

---
Best Regards, Laurentiu
