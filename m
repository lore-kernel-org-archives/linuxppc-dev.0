Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81804DE13C
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 01:22:45 +1000 (EST)
Date: Mon, 25 May 2009 16:22:38 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V3 2/4] AC97 driver for mpc5200
Message-ID: <20090525152237.GK18290@sirena.org.uk>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013849.3073.96729.stgit@terra>
	<fa686aa40905242316j3e8b46e7mcc71dc34df209003@mail.gmail.com>
	<9e4733910905250815r4a6fa205s26531f08fe99131a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910905250815r4a6fa205s26531f08fe99131a@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 11:15:34AM -0400, Jon Smirl wrote:

> The link always runs at 12.288Mhz. Each frame is 256 bits. Worst case
> you wait for two frames, 42us. If it doesn't respond in 42us the codec

Note that some embedded systems will choose to vary the AC97 link clock.
The most common case is where there's a PLL on the CODEC - the CODEC
will start up misclocked at whatever the input frequency it's got is and
then be reclocked using register writes to configure the PLL.
