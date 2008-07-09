Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89F92DDF08
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 18:55:44 +1000 (EST)
Subject: Re: [PATCH 0/3] ALSA fixes for non-coherent ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080709083111.44860@gmx.net>
References: <s5h1w2vc9js.wl%tiwai@suse.de>  <20080709083111.44860@gmx.net>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 18:55:35 +1000
Message-Id: <1215593735.8970.361.camel@pasglop>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 10:31 +0200, Gerhard Pircher wrote:
> > 
> > The patches are found also on my git tree, dma-fix branch of
> >
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> > 
> > Any comments and test reports are appreciated, especially about
> > dma_mmap_coherent() addition.
> I know this answer comes a little bit late, but my PPC machine was not
> working for two weeks due to a hardware failure. I tested the patch on
> 2.6.26-rc9 and it seems to work fine so far with my emu10k soundcard.
> I just had to add "#include <linux/dma-mapping.h>" to pcm_native.c.
> Otherwise it wouldn't compile.

Can I get the latest powerpc-side patches so I can review-ack them in
time for the merge window ?

Cheers,
Ben.
