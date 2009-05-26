Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF9C2DE026
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 21:04:51 +1000 (EST)
Date: Tue, 26 May 2009 12:04:43 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH V4 0/5] AC97 driver for mpc5200
Message-ID: <20090526110443.GB8969@sirena.org.uk>
References: <20090525221406.21370.30326.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090525221406.21370.30326.stgit@terra>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 06:15:05PM -0400, Jon Smirl wrote:

> reset retries. Removing the retries makes the driver fail to load about 5% of the time. An oscilliscope is 

Please also send a patch sorting this out in the STAC9766 driver as
requested.  Other than that and the udelay() thing it looks like we can
merge this now - there's the reset issue and probably other things to
clean up but it'd be better to do those as incremental patches.

> needed to figure out what is going on with failed resets. Both pcm030 and Efika ocasionally fail to reset 
> and they use different codec chips.

Like I say, it may be worth checking into the startup of the master
clock for the CODECs, especially if it's an output from the SoC on both
boards.
