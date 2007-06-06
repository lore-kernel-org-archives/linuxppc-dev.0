Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6455CDDE3B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 03:07:36 +1000 (EST)
Subject: Re: [PATCH] Fix drivers/rtc/Kconfig for powerpc
From: Jon Loeliger <jdl@freescale.com>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1181149064.5674.134.camel@rhino>
References: <1181149064.5674.134.camel@rhino>
Content-Type: text/plain
Message-Id: <1181149622.12740.32.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 06 Jun 2007 12:07:02 -0500
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

On Wed, 2007-06-06 at 11:57, Wade Farnsworth wrote:
> The powerpc arch uses CONFIG_PPC instead of CONFIG_POWERPC.  This fixes
> drivers/rtc/Kconfig to use the correct config option.
> 
> Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
> 
> ---
> This is a resubmission of a patch I sent a few weeks ago.  I'm
> resubmitting this as I haven't seen any activity regarding this patch
> since I submitted it.

Did you miss where I ACK'ed it 16-May-2007? :-)


        From: 	Jon Loeliger <jdl@freescale.com>
        To: 	Wade Farnsworth <wfarnsworth@mvista.com>
        Cc: 	linuxppc-dev <linuxppc-dev@ozlabs.org>, rtc-linux@googlegroups.com
        Subject: Re: [PATCH] Fix drivers/rtc/Kconfig for powerpc
        Date: 	Wed, 16 May 2007 11:31:26 -0500	
        
        On Tue, 2007-05-15 at 11:53, Wade Farnsworth wrote:
        > The powerpc arch uses CONFIG_PPC instead of CONFIG_POWERPC.  This makes
        > drivers/rtc/Kconfig to use the correct config option.
        > 
        > Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
        
        Acked-by: Jon Loeliger <jdl@freescale.com>

jdl
