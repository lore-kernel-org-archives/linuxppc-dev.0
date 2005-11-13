Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 281C268713
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Nov 2005 08:04:37 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.62.0511131845230.17491@numbat.sonytel.be>
References: <200511080502.jA852dWI011502@hera.kernel.org>
	<Pine.LNX.4.62.0511131845230.17491@numbat.sonytel.be>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 08:00:33 +1100
Message-Id: <1131915634.5504.69.camel@gaston>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > --- a/drivers/macintosh/Kconfig
> > +++ b/drivers/macintosh/Kconfig
> > @@ -169,6 +169,25 @@ config THERM_PM72
> >  	  This driver provides thermostat and fan control for the desktop
> >  	  G5 machines. 
> >  
> > +config WINDFARM
> > +	tristate "New PowerMac thermal control infrastructure"
> 
> Shouldn't this depend on some PowerMac-related variables, to prevent it from
> showing up on m68k?

Well, the windfarm core is not really platform specific at all ...
Christoph even proposed to move it to some more "common" place, though
as I said, I want to work on it a bit more before that happens.

Ben.
