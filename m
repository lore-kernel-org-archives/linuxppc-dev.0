Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id C3A2BDDF7F
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 20:36:47 +1000 (EST)
Date: Wed, 23 Jul 2008 11:36:40 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] Support internal I2S clock sources on
	MPC5200
Message-ID: <20080723103639.GB8377@sirena.org.uk>
References: <20080722235349.11648.90112.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080722235349.11648.90112.stgit@terra>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 07:53:49PM -0400, Jon Smirl wrote:
> Support internal I2S clock sources on MPC5200

Looks good from an ASoC point of view.  There's quite a few checkpatch
warnings that should be fixed (all fairly straightforward, though) but
other than that I'm happy to apply it with Grant's ack.
