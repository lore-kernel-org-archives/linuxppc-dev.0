Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B5A4B6FEA
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 06:09:21 +1100 (EST)
Message-ID: <4F638FD6.6070004@freescale.com>
Date: Fri, 16 Mar 2012 14:09:10 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/8xxx: remove 85xx/86xx restrictions from
 fsl_guts.h
References: <1329412870-16716-1-git-send-email-timur@freescale.com>
 <177AB6E4-E148-43EE-BBD5-1348B6796EAA@kernel.crashing.org>
In-Reply-To: <177AB6E4-E148-43EE-BBD5-1348B6796EAA@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> If you are doing this clean, just finish it.  There are only a small handful of users of ccsr_guts_8{5,6}xx:
> 
> arch/powerpc/include/asm/fsl_guts.h:static inline void guts_set_dmacr(struct ccsr_guts_86xx __iomem *guts,
> arch/powerpc/include/asm/fsl_guts.h:static inline void guts_set_pmuxcr_dma(struct ccsr_guts_86xx __iomem *guts,
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c:     struct ccsr_guts_86xx __iomem *guts;
> arch/powerpc/platforms/85xx/p1022_ds.c: struct ccsr_guts_85xx __iomem *guts;
> arch/powerpc/platforms/85xx/p1022_ds.c: struct ccsr_guts_85xx __iomem *guts;

Ok.  Can you push your tree to git.kernel.org, so that I can be sure to
provide a clean patch?

-- 
Timur Tabi
Linux kernel developer at Freescale
