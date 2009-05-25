Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8367CDE044
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 20:43:39 +1000 (EST)
Date: Mon, 25 May 2009 11:43:29 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V3 0/4] mpc5200 audio rework for AC97
Message-ID: <20090525104329.GE18290@sirena.org.uk>
References: <20090525013606.3073.86753.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090525013606.3073.86753.stgit@terra>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 09:38:45PM -0400, Jon Smirl wrote:
> The following series implements audio support for the mpc5200. It adds an AC97 driver and STAC9766 codec driver. 
> Board support for the Efika and Phytec pcm030 are also included.

> I've tried to implement the feedback received on the previous two versions.

Please also add the fixes for the reset code in the CODEC driver that I
asked for.
