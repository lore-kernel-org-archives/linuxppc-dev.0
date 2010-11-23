Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67CC3B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Nov 2010 02:02:59 +1100 (EST)
Date: Tue, 23 Nov 2010 14:53:53 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] MPC5200: Eliminate duplicate include of of_device.h
Message-ID: <20101123145352.GM18960@rakim.wolfsonmicro.main>
References: <alpine.LNX.2.00.1011222246250.6285@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1011222246250.6285@swampdragon.chaosbits.net>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 22, 2010 at 10:54:03PM +0100, Jesper Juhl wrote:
> 
> Eliminate duplicate  #include <linux/of_device.h>  from 
> sound/soc/fsl/mpc5200_dma.c

Applied, thanks.
