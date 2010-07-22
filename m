Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37C1C1007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 02:57:49 +1000 (EST)
Date: Thu, 22 Jul 2010 17:49:28 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][v2] powerpc: rename immap_86xx.h to fsl_guts.h, and
	add 85xx support
Message-ID: <20100722164927.GC16119@rakim.wolfsonmicro.main>
References: <1279816410-19079-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279816410-19079-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	kumar.gala@freescale.com, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 22, 2010 at 11:33:30AM -0500, Timur Tabi wrote:
> The immap_86xx.h header file only defines one data structure: the "global
> utilities" register set found on Freescale PowerPC SOCs.  Rename this file
> to fsl_guts.h to reflect its true purpose, and extend it to cover the "GUTS"
> register set on 85xx chips.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
