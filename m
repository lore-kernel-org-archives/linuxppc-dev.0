Return-Path: <timur.tabi@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 2FE3C1007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 05:22:05 +1100 (EST)
Received: by gyf2 with SMTP id 2so2070726gyf.15
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 11:22:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1286480203-28227-2-git-send-email-timur@freescale.com>
References: <1286480203-28227-1-git-send-email-timur@freescale.com>
	<1286480203-28227-2-git-send-email-timur@freescale.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Thu, 14 Oct 2010 13:21:33 -0500
Message-ID: <AANLkTimWgbJ0oDsQkXxzjQ_pDxm_Vd+PJRhQJzN0BLTc@mail.gmail.com>
Subject: Re: [PATCH 2/2] [v2] powerpc/85xx: add DIU support to the Freecale
	P1022DS reference board
To: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	alsa-devel mailing list <alsa-devel@alsa-project.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark, can you pick up this patch for us?  Because it depends on
"powerpc: rename immap_86xx.h to fsl_guts.h, and add 85xx support", it
will break the build if we apply to powerpc-next.

You can grab the patch from http://patchwork.ozlabs.org/patch/67095/

On Thu, Oct 7, 2010 at 2:36 PM, Timur Tabi <timur@freescale.com> wrote:
> The Freescale P1022DS has an on-chip video controller called the DIU, and=
 a
> driver for this device already exists. =A0Update the platform file for th=
e
> P1022DS reference board to enable the driver, and update the defconfig fo=
r
> Freescale MPC85xx boards to add the driver.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

--=20
Timur Tabi
Linux kernel developer at Freescale
