Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F65ADDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 09:37:57 +1100 (EST)
Message-ID: <476AEEB3.2010403@freescale.com>
Date: Thu, 20 Dec 2007 16:37:39 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>
	<20071220040633.GA6732@lixom.net> <476A7B23.2040905@freescale.com>
	<20071220223943.GA24138@lixom.net>
In-Reply-To: <20071220223943.GA24138@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

>> I was just following the example from another board file.  However, the 'soc' 
>> node in the device tree does not have a compatible property, so I don't how to 
>> change this.
> 
> Then add an appropriate compatible entry to it, please.

None of the SOC nodes in any DTS have a "compatible" entry.  I understand the 
issue, but you're asking me to fix a larger problem, one that is beyond the 
scope of this patch.  You're saying that *all* SOC needs are incorrectly defined 
and need to be probed differently.

-- 
Timur Tabi
Linux kernel developer at Freescale
