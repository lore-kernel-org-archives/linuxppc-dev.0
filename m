Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB01BDDEBB
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 02:32:24 +1000 (EST)
Subject: Re: [PATCH] Fix drivers/rtc/Kconfig for powerpc
From: Jon Loeliger <jdl@freescale.com>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1179248008.8132.142.camel@rhino>
References: <1179248008.8132.142.camel@rhino>
Content-Type: text/plain
Message-Id: <1179333086.7018.11.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 16 May 2007 11:31:26 -0500
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 11:53, Wade Farnsworth wrote:
> The powerpc arch uses CONFIG_PPC instead of CONFIG_POWERPC.  This makes
> drivers/rtc/Kconfig to use the correct config option.
> 
> Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

Acked-by: Jon Loeliger <jdl@freescale.com>
