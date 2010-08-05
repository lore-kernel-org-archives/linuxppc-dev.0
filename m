Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1D7DB6F14
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 21:42:22 +1000 (EST)
Date: Thu, 5 Aug 2010 12:42:15 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for disabled
	SSI nodes
Message-ID: <20100805114215.GC13146@rakim.wolfsonmicro.main>
References: <1280962268-31407-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280962268-31407-1-git-send-email-timur@freescale.com>
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

On Wed, Aug 04, 2010 at 05:51:08PM -0500, Timur Tabi wrote:
> Add support for adding "status = disabled" to an SSI node to incidate that it
> is not wired on the board.  This replaces the not-so-intuitive previous method
> of omitting a codec-handle property.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
