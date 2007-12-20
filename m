Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62F20DDE21
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 09:43:29 +1100 (EST)
Message-ID: <476AF015.5040600@freescale.com>
Date: Thu, 20 Dec 2007 16:43:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	<20071220040633.GA6732@lixom.net>
	<476A7B23.2040905@freescale.com>	<20071220223943.GA24138@lixom.net>
	<476AEEB3.2010403@freescale.com>
In-Reply-To: <476AEEB3.2010403@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Olof Johansson wrote:
> 
>>> I was just following the example from another board file.  However, the 'soc' 
>>> node in the device tree does not have a compatible property, so I don't how to 
>>> change this.
>> Then add an appropriate compatible entry to it, please.
> 
> None of the SOC nodes in any DTS have a "compatible" entry.

Not quite true; ep88xc, mpc8272ads, and pq2fads have them.

-Scott
