Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DEABB6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 08:37:12 +1000 (EST)
Date: Mon, 22 Aug 2011 23:30:31 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] sound/soc/fsl/fsl_dma.c: add missing of_node_put
Message-ID: <20110822223031.GF30609@opensource.wolfsonmicro.com>
References: <1314022961-27513-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314022961-27513-1-git-send-email-timur@freescale.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de,
	devicetree-discuss@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	perex@perex.cz, julia@diku.dk, linuxppc-dev@lists.ozlabs.org, lrg@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2011 at 09:22:41AM -0500, Timur Tabi wrote:
> of_parse_phandle increments the reference count of np, so this should be
> decremented before trying the next possibility.
> 
> Since we don't actually use np, we can decrement the reference count
> immediately.

Applied, thanks.
