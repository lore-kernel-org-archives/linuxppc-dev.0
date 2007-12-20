Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02242DDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 09:44:51 +1100 (EST)
Message-ID: <476AF061.1030605@freescale.com>
Date: Thu, 20 Dec 2007 16:44:49 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>		<9e4733910712201429q5845e786yb2ecb3ce9c8b7871@mail.gmail.com>		<476AED87.3090703@freescale.com>	<9e4733910712201438u2165aa77t8eab91bccb4c5bda@mail.gmail.com>
	<476AEF47.8040802@freescale.com>
In-Reply-To: <476AEF47.8040802@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Jon Smirl wrote:
> 
>> mpc5200 does it like this:
>> of_platform_bus_probe(NULL, NULL, NULL);
> 
> I think that tells the OF base code to probe everything in the device tree, 
> which is probably overkill.  I think fsl_soc.c covers most of the device tree, 
> but the SSI is not defined in fsl_soc.c.

Not quite; it tells it to use a built-in list of bus matches.  Most of 
which are device_type-based, FWIW.

-Scott
