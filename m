Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48534B7D2E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 21:22:06 +1000 (EST)
Date: Wed, 5 May 2010 12:22:08 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/8610: add probing for individual DMA
	channels, not just DMA controllers
Message-ID: <20100505112208.GD5754@opensource.wolfsonmicro.com>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
	<2928D88F-057B-498C-8A11-F7193429A90D@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2928D88F-057B-498C-8A11-F7193429A90D@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 04, 2010 at 12:20:13PM -0500, Kumar Gala wrote:
> On May 3, 2010, at 4:54 PM, Timur Tabi wrote:

> > A future version of the MPC8610 HPCD's ASoC DMA driver will probe on individual
> > DMA channel nodes, so the DMA controller nodes' compatible string must be listed
> > in mpc8610_ids[] for the probe to work.
> > 
> > Also remove the "gianfar" compatible from mpc8610_ids[], since there is no
> > gianfar (or any other networking device) on the 8610.
> > 
> > Signed-off-by: Timur Tabi <timur@freescale.com>

> Acked-by: Kumar Gala <galak@kernel.crashing.org>

Just looking at the scheduling here with regard to the merge window and
the fact that this doesn't seem to hurt the existing drivers perhaps it
makes sense to merge this via the PowerPC tree immediately?
