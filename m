Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9715DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 20:23:30 +1100 (EST)
Message-ID: <48EE2F97.9090807@freescale.com>
Date: Thu, 09 Oct 2008 11:21:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
References: <1223495845-14149-1-git-send-email-timur@freescale.com>		<1223496186.8157.82.camel@pasglop>		<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>	<1223498380.8157.86.camel@pasglop>	<48ED1B9E.3020907@freescale.com>
	<48EE2A49.10405@genesi-usa.com>
In-Reply-To: <48EE2A49.10405@genesi-usa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> You do realise it's entirely possible to build a kernel which supports 50
> different Freescale CPUs all in one?
> 
> Enabling CHRP, PMAC support *AND* non-CHRP platforms is possible in the 
> same
> binary. 

It's possible to build a kernel with 50 network drivers, too.  That 
doesn't mean they should all be "default y".  The kernel build takes 
long enough as is.

> If you really want to build a single-cpu single-board kernel, disable CHRP
> and PMAC for those board configs,

If you really want to build a targets-everything kernel, then turn on 
everything.  Go ahead and create a 6xx_defconfig that has support for 
everything enabled.  But don't cause huge heaps of stuff to be enabled 
for everyone that does a "make oldconfig" with a config file that 
predates change d8267c1a36864fc30a2ce01f4349a8f2931ae741.

-Scott
