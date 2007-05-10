Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 330FEDDEC7
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 01:49:26 +1000 (EST)
Message-ID: <46433EFF.6030608@freescale.com>
Date: Thu, 10 May 2007 10:49:19 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 09/13] fsl_soc: Factor fsl_get_bus_freq() out of the wdt
	init.
References: <20070507182953.GH26920@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.64.0705092233070.29512@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0705092233070.29512@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Mon, 7 May 2007, Scott Wood wrote:
>>+u32 fsl_get_bus_freq(void)
> 
> Can we call this something more explicit, like fsl_get_sys_freq().
> Otherwise this looks fine.

It's bus-frequency in the device tree, not sys-frequency, and the latter 
doesn't seem any more explicit to me...  What about fsl_get_csb_freq()?

-Scott
