Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD56CDDF39
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:15:21 +1100 (EST)
Message-ID: <477D2673.5090203@freescale.com>
Date: Thu, 03 Jan 2008 12:16:19 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>, Timur Tabi <timur@freescale.com>,
	linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
	<20080102184957.GB2007@sirena.org.uk>
In-Reply-To: <20080102184957.GB2007@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Brown wrote:

> The machine support code (fabric driver in PowerPC terms, I think?)
> tells the core how everything is connected together by registering
> devices representing the links (eg, I2S) between the codecs, CPU and
> other devices.  The ASoC core is then responsible for ensuring that all
> the required components are present before it registers with the ALSA
> core.

I'm no expert on this, but I think from the PowerPC point-of-view, the *ideal* 
situation would be if the ASoC fabric driver were generic, maybe even part of 
ASoC itself, and everything it needed could be obtained from the device tree.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
