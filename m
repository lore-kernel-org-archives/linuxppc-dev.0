Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 04864DE0CD
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 03:51:36 +1000 (EST)
Date: Tue, 22 Jul 2008 18:51:22 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Message-ID: <20080722175121.GA6432@sirena.org.uk>
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
	<9e4733910807220938k7452f40co8d51e4b03e79ee8b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807220938k7452f40co8d51e4b03e79ee8b@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
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

On Tue, Jul 22, 2008 at 12:38:30PM -0400, Jon Smirl wrote:
> On 7/22/08, Grant Likely <grant.likely@secretlab.ca> wrote:

> >  +int of_snd_soc_register_platform(struct snd_soc_platform *platform,
> >  +                                struct device_node *node,
> >  +                                struct snd_soc_dai *cpu_dai);
> >  +

> This doesn't compile for me.  Where is struct snd_soc_dai being defined?

> It used to be....

In ALSA and ASoC git struct snd_soc_{cpu,codec}_dai have been replaced
by a shared snd_soc_dai defined in soc.h as the previous two were.
