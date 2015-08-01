Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0139.outbound.protection.outlook.com [65.55.169.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC76E1A0CDD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 10:45:21 +1000 (AEST)
Message-ID: <1438389906.19345.101.camel@freescale.com>
Subject: Re: [PATCH v5] powerpc/rcpm: add RCPM driver
From: Scott Wood <scottwood@freescale.com>
To: <Yuantian.Tang@freescale.com>
CC: <b07421@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Chenhui Zhao
 <chenhui.zhao@freescale.com>
Date: Fri, 31 Jul 2015 19:45:06 -0500
In-Reply-To: <1435304656-34505-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1435304656-34505-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-06-26 at 15:44 +0800, Yuantian.Tang@freescale.com wrote:
> +static void rcpm_v1_set_ip_power(bool enable, u32 *mask)
> +{
> +     if (enable)
> +             setbits32(&rcpm_v1_regs->ippdexpcr, *mask);
> +     else
> +             clrbits32(&rcpm_v1_regs->ippdexpcr, *mask);
> +}
> +
> +static void rcpm_v2_set_ip_power(bool enable, u32 *mask)
> +{
> +     if (enable)
> +             setbits32(&rcpm_v2_regs->ippdexpcr[0], *mask);
> +     else
> +             clrbits32(&rcpm_v2_regs->ippdexpcr[0], *mask);
> +}

Why do these take "u32 *mask" instead of "u32 mask"?

-Scott
