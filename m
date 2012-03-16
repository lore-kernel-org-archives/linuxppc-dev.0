Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 61911B6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 06:39:42 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add missing config option for CACHE SRAM
 code
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1328004920-29727-1-git-send-email-claudiu.manoil@freescale.com>
Date: Fri, 16 Mar 2012 14:38:19 -0500
Message-Id: <E008CEA3-768B-4E96-BAA7-E908AED28EFD@kernel.crashing.org>
References: <1328004920-29727-1-git-send-email-claudiu.manoil@freescale.com>
To: Claudiu Manoil <claudiu.manoil@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 31, 2012, at 4:15 AM, Claudiu Manoil wrote:

> fsl_85xx_l2ctlr.o and fsl_85xx_cache_sram.o are built only
> if CONFIG_FSL_85XX_CACHE_SRAM is defined. The driver that
> qualifies and wants to make use of the CACHE SRAM's exported
> API (i.e. a freescale net driver) should (be able to) select
> this config option.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig |    9 +++++++++
> 1 files changed, 9 insertions(+), 0 deletions(-)

applied

- k
