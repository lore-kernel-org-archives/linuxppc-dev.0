Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 8447CDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 00:23:28 +1000 (EST)
Date: Tue, 22 Jul 2008 15:10:34 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 0/3] ALSA SoC: MPC5200 audio driver
Message-ID: <20080722141027.GB12555@sirena.org.uk>
References: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>
	<20080722092646.GA7251@sirena.org.uk>
	<9e4733910807220638u5cf48424l92ba780ecd9e3d9d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807220638u5cf48424l92ba780ecd9e3d9d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 09:38:11AM -0400, Jon Smirl wrote:

> These drivers are going to get hit with immediate patches.  The DMA is
> not broken out so that AC97 support can be fixed for the Efika.

Further updates shouldn't present a problem - if anything, it should be
easier easier to review incremental patches.
