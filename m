Return-Path: <lgirdwood@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 9D526B6EFE
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jul 2010 04:10:38 +1000 (EST)
Received: by wye20 with SMTP id 20so506509wye.15
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 11:10:36 -0700 (PDT)
Subject: Re: [PATCH][v2] powerpc: rename immap_86xx.h to fsl_guts.h, and
	add 85xx support
From: Liam Girdwood <lrg@slimlogic.co.uk>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <84CE2602-9E81-473B-8E5F-4F4AD0E07484@freescale.com>
References: <1279816410-19079-1-git-send-email-timur@freescale.com>
	<20100722164927.GC16119@rakim.wolfsonmicro.main>
	<84CE2602-9E81-473B-8E5F-4F4AD0E07484@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 19:10:28 +0100
Message-ID: <1279908628.3076.1.camel@odin>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-22 at 13:43 -0500, Kumar Gala wrote:
> On Jul 22, 2010, at 11:49 AM, Mark Brown wrote:
> 
> > On Thu, Jul 22, 2010 at 11:33:30AM -0500, Timur Tabi wrote:
> >> The immap_86xx.h header file only defines one data structure: the "global
> >> utilities" register set found on Freescale PowerPC SOCs.  Rename this file
> >> to fsl_guts.h to reflect its true purpose, and extend it to cover the "GUTS"
> >> register set on 85xx chips.
> >> 
> >> Signed-off-by: Timur Tabi <timur@freescale.com>
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> 
> - k

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
