Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F62FDDE1B
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 21:01:41 +1000 (EST)
Message-Id: <FECB7589-9A1B-48E5-805F-4253E6FECC9F@freescale.com>
From: Timur Tabi <timur@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080703163351.GJ2284@secretlab.ca>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [alsa-devel] [PATCH 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
Date: Fri, 4 Jul 2008 07:05:17 -0400
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<9e4733910807020827k115fe63r7a0dd09daffc1895@mail.gmail.com>
	<20080703163351.GJ2284@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 3, 2008, at 12:33 PM, Grant Likely wrote:

> Yes, but you hadn't written these functions when I wrote this helper.
> :-P.  I believe ASoC v2 makes all this stuff unnecessary, but I'm
> waiting for v2 to hit mainline before I port forward.

FYI, it took me about a month to port my drivers to ASoC V2.  I had  
more work than most people because I addressed issues that others  
drivers didn't.  For instance, my CS4270 driver is the only codec  
driver in V2 that supports multiple instances of itself.
