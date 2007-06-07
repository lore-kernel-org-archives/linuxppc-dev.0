Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A5B5DDE2E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:37:58 +1000 (EST)
Subject: Re: [PATCH] Fix drivers/rtc/Kconfig for powerpc
From: Jon Loeliger <jdl@freescale.com>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1181233980.5674.174.camel@rhino>
References: <1181149064.5674.134.camel@rhino>
	<1181149622.12740.32.camel@ld0161-tx32>
	<1181150240.5674.139.camel@rhino>
	<1181232488.31686.19.camel@ld0161-tx32>
	<1181233980.5674.174.camel@rhino>
Content-Type: text/plain
Message-Id: <1181234266.31686.37.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 07 Jun 2007 11:37:46 -0500
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 11:33, Wade Farnsworth wrote:
> 
> But since this is in drivers/rtc/Kconfig, wouldn't the maintainer of
> that subsystem be expected to pick this up?

Oh, sure.  In which case he/she may be waiting on
someone over in PowerPC land to ACK it first. :-)
Dunno.

jdl
