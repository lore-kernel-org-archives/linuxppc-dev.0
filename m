Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2CD3B6F85
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 11:04:45 +1000 (EST)
Date: Wed, 17 Aug 2011 10:04:34 +0900
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: claim the IRQ when the fsl_ssi device is
	probed, not opened
Message-ID: <20110817010433.GC27099@opensource.wolfsonmicro.com>
References: <1313534865-7795-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313534865-7795-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 16, 2011 at 06:47:45PM -0400, Timur Tabi wrote:
> The PowerPC Freescale SSI driver is claiming the IRQ when the IRQ when
> the device is opened, which means that the /proc/interrupts entry for
> the SSI exists only during playback or capture.  This also meant that
> the user won't know that the IRQ number is wrong until he tries to use
> the device.  Instead, we should claim the IRQ when the device is probed.

Applied, thanks.
