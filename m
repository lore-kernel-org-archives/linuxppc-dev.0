Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F133DE0D5
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 21:15:25 +1000 (EST)
Date: Sun, 24 May 2009 12:15:13 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Message-ID: <20090524111512.GD4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231301.17919.88294.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090523231301.17919.88294.stgit@terra>
Subject: Re: [alsa-devel] [PATCH V2 3/9] Rename the PSC functions to DMA
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 23, 2009 at 07:13:01PM -0400, Jon Smirl wrote:
> Rename the functions in the mpc5200 DMA file from i2s based names to dma ones to reflect the file they are in.

I'm OK with both these refactoring patches if Grant is - Grant, if I
could get your ack I'd like to merge these as soon as possible since
they're very big changes and it'd cut down on review effort.
