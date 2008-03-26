Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54944DE61E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 03:26:22 +1100 (EST)
Message-ID: <47EA792A.5000109@freescale.com>
Date: Wed, 26 Mar 2008 11:26:18 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: ppc platform for AMCC-440EPx - ELDK to the rescue
References: <20080326130837.762DBDE2FB@ozlabs.org>
In-Reply-To: <20080326130837.762DBDE2FB@ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Steve Heflin wrote:
> After that, I was able to see that it was the "setup_hose" function 
> called from /arch/ppc/platforms/4xx/sequoia.c that caused my board to 
> hang. This Sequoia spinoff board has the PCI Host Bridge disabled which 
> I didn't realize until that point.
> 
> Looking back at the powerpc platform, I don't see how to disable the 
> Host Bridge initialization without disabling the entire PCI bus.  This 
> board does have 2 devices hooked on the PCI bus, just no need for a Host 
> Bridge.

And how do you propose to talk to said PCI devices without configuring 
the host bridge?

> Also, I fail to see what the DTS virtualization layer of the hardware 
> buys us.

Maintainability.  Ease of porting to new hardware.

> When debugging, it's so much harder to use than the ppc 
> platform's straight forward and standard methodologies.  I can't 
> understand to goal to eliminate the ppc platform,

Are you volunteering to maintain it, including the rest of us not having 
to care when we change something in common code that breaks it?

> especially given the 
> fact that DENX's ELDK is still using it with Linux 2.6.24.2 !!

Take that up with Denx.

-Scott
