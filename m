Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CCBD1007D4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 07:49:41 +1100 (EST)
Date: Thu, 14 Oct 2010 21:49:49 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH 2/2] [v2] powerpc/85xx: add DIU support to the Freecale
	P1022DS reference board
Message-ID: <20101014204949.GA14479@opensource.wolfsonmicro.com>
References: <1286480203-28227-1-git-send-email-timur@freescale.com>
	<1286480203-28227-2-git-send-email-timur@freescale.com>
	<AANLkTimWgbJ0oDsQkXxzjQ_pDxm_Vd+PJRhQJzN0BLTc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimWgbJ0oDsQkXxzjQ_pDxm_Vd+PJRhQJzN0BLTc@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 14, 2010 at 01:21:33PM -0500, Timur Tabi wrote:
> Mark, can you pick up this patch for us?  Because it depends on
> "powerpc: rename immap_86xx.h to fsl_guts.h, and add 85xx support", it
> will break the build if we apply to powerpc-next.
> 
> You can grab the patch from http://patchwork.ozlabs.org/patch/67095/

Done, but I had to fix up what looked like an add/add conflict with
headers in the file.  Since I was editing that area of the file anyway I
also dropped the #define DEBUG as it looked like a mistake.  Please send
followup patch(es) correcting things if I messed up any of that.
