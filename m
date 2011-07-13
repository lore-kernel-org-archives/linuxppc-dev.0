Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 013D1B6F77
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 18:27:40 +1000 (EST)
Date: Wed, 13 Jul 2011 17:27:22 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] drivers/video: use strings to specify the Freescale
	DIU monitor port
Message-ID: <20110713082722.GJ13701@linux-sh.org>
References: <1310243894-2660-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310243894-2660-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 09, 2011 at 03:38:14PM -0500, Timur Tabi wrote:
> Instead of using ill-defined numbers (0, 1, and 2) for the monitor port, allow
> the user to specify the port by name ("dvi", "lvds", or "dlvds").  This works
> on the kernel command line, the module command-line, and the sysfs "monitor"
> device.
> 
> Note that changing the monitor port does not currently work on the P1022DS,
> because the code that talks to the PIXIS FPGA is broken.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> Acked-by: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/platforms/512x/mpc512x_shared.c |   22 +++-----
>  arch/powerpc/platforms/85xx/p1022_ds.c       |   47 ++++++++---------
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |   55 +++++++++----------
>  arch/powerpc/sysdev/fsl_soc.h                |   25 ++++++---
>  drivers/video/fsl-diu-fb.c                   |   74 +++++++++++++++++++-------
>  5 files changed, 128 insertions(+), 95 deletions(-)
> 
Applied, thanks.
