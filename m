Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id E4895DDF9A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 21:52:12 +1000 (EST)
Date: Tue, 22 Jul 2008 12:52:06 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 0/3] ALSA SoC: MPC5200 audio driver
Message-ID: <20080722115205.GA12555@sirena.org.uk>
References: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>
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

On Tue, Jul 22, 2008 at 12:58:09AM -0600, Grant Likely wrote:

> Here is the latest series for adding MPC5200 I2S and TI AIC26 codec
> support to ALSA SoC.  I believe all the comments are addressed and I
> hope that this series is now ready to be merged.  I would really like
> to see these ones land in 2.6.27.

I added the changes in the following fairly trivial patch series to
these to allow tlv320aic26 build cleanly on my ARM platforms.
