Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A73B7B6F87
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 08:37:12 +1000 (EST)
Date: Mon, 22 Aug 2011 23:30:16 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 2/2] sound/soc/fsl/mpc8610_hpcd.c: add missing of_node_put
Message-ID: <20110822223016.GE30609@opensource.wolfsonmicro.com>
References: <1313823721-16930-2-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313823721-16930-2-git-send-email-julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>,
	Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 20, 2011 at 09:02:01AM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> The first change is to add an of_node_put, since codec_np has previously
> been allocated.  The rest of the patch reorganizes the error handling code
> so the only code executed is that which is needed.

Applied, thanks.
