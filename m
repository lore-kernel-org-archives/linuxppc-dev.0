Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0ED28B7D5F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 22:35:51 +1000 (EST)
Date: Wed, 5 May 2010 13:35:45 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc/8610: add probing for
	individual DMA channels, not just DMA controllers
Message-ID: <20100505123545.GA7139@rakim.wolfsonmicro.main>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
	<2928D88F-057B-498C-8A11-F7193429A90D@freescale.com>
	<20100505112208.GD5754@opensource.wolfsonmicro.com>
	<g2ied82fe3e1005050439v70066822h7518ac53f97e97f6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <g2ied82fe3e1005050439v70066822h7518ac53f97e97f6@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 05, 2010 at 06:39:01AM -0500, Timur Tabi wrote:
> On Wed, May 5, 2010 at 6:22 AM, Mark Brown

> > Just looking at the scheduling here with regard to the merge window and
> > the fact that this doesn't seem to hurt the existing drivers perhaps it
> > makes sense to merge this via the PowerPC tree immediately?

> Aren't we a little late in the cycle for a patch that doesn't do anything?

It seems to be safe enough for -next.
