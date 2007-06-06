Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 7C9B8DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 03:17:22 +1000 (EST)
Subject: Re: [PATCH] Fix drivers/rtc/Kconfig for powerpc
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1181149622.12740.32.camel@ld0161-tx32>
References: <1181149064.5674.134.camel@rhino>
	<1181149622.12740.32.camel@ld0161-tx32>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 10:17:20 -0700
Message-Id: <1181150240.5674.139.camel@rhino>
Mime-Version: 1.0
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

On Wed, 2007-06-06 at 12:07 -0500, Jon Loeliger wrote:
> On Wed, 2007-06-06 at 11:57, Wade Farnsworth wrote:
> > The powerpc arch uses CONFIG_PPC instead of CONFIG_POWERPC.  This fixes
> > drivers/rtc/Kconfig to use the correct config option.
> > 
> > Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
> > 
> > ---
> > This is a resubmission of a patch I sent a few weeks ago.  I'm
> > resubmitting this as I haven't seen any activity regarding this patch
> > since I submitted it.
> 
> Did you miss where I ACK'ed it 16-May-2007? :-)

Ah okay, maybe I don't understand what that means.  When you say
"Acked-by" does that mean you'll push it upstream?

What I meant was I haven't seen anybody pick up this patch yet, and
would like to know it if will be, or if there is something else I need
to do.

--Wade

> 
> 
>         From: 	Jon Loeliger <jdl@freescale.com>
>         To: 	Wade Farnsworth <wfarnsworth@mvista.com>
>         Cc: 	linuxppc-dev <linuxppc-dev@ozlabs.org>, rtc-linux@googlegroups.com
>         Subject: Re: [PATCH] Fix drivers/rtc/Kconfig for powerpc
>         Date: 	Wed, 16 May 2007 11:31:26 -0500	
>         
>         On Tue, 2007-05-15 at 11:53, Wade Farnsworth wrote:
>         > The powerpc arch uses CONFIG_PPC instead of CONFIG_POWERPC.  This makes
>         > drivers/rtc/Kconfig to use the correct config option.
>         > 
>         > Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
>         
>         Acked-by: Jon Loeliger <jdl@freescale.com>
> 
> jdl
> 
> 
