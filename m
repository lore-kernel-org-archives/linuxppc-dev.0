Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32346DDE45
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 04:50:19 +1000 (EST)
Message-ID: <46B76D64.5050700@freescale.com>
Date: Mon, 06 Aug 2007 13:50:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi, register mmc_spi
	stub
References: <20070726135738.GB5643@localhost.localdomain>	<692e6dabbfb62dc6d6ace3ea7552ef68@kernel.crashing.org>	<20070801123400.GA20200@localhost.localdomain>
	<44eb4173dacc69037ea9acfb7880818f@kernel.crashing.org>
In-Reply-To: <44eb4173dacc69037ea9acfb7880818f@kernel.crashing.org>
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

Segher Boessenkool wrote:
>>p.s. mpc8272ads.dts is broken wrt spaces/tabs, very.
> 
> 
> Care to do a cleanup patch?  Good for your karma ;-)

I've got one in my 82xx patchset (a respin of which should be coming soon).

There's a lot more broken in there than just spaces/tabs, BTW. :-)

-Scott
