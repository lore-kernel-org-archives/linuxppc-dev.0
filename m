Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 81B892BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Dec 2004 02:10:01 +1100 (EST)
Message-ID: <41B9BC95.2040402@anagramm.de>
Date: Fri, 10 Dec 2004 16:11:17 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Martin Krause <Martin.Krause@tqs.de>,
	linuxppc-embedded@ozlabs.org
References: <DE2CC66C40EAB74EA6D66AC71BF98E1E016AF54E@TQ-MAILSRV-1>
In-Reply-To: <DE2CC66C40EAB74EA6D66AC71BF98E1E016AF54E@TQ-MAILSRV-1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: AW: video card for Lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Martin!

> From the silicon motion homepage you could get a framebuffer driver for
> the SM501 PCI card. This should work without great modifications for
> PPC systems.

Thank you, I know that thing. I started with that driver, but I did
quite a lot of code cleanup (I guess there are lots of leftovers from 
the SM7xx parts). I am about to put this into a loadable kernel module 
fbdev driver. Later on, we might need some power management, use it on 
different resolutions and use the other on-chip peripherals...

> On our board (with MPC5200 CPU), we connected the SM501 not over PCI,
> but over the local bus. You could find the driver in the 
> linuxppc_2_4_devel Kernel from the Denx CVS server. Look at: http://www.denx.de/e/index1.php?head=solution-se-head&main=solution-se&subnav=solution-se-subnav&logo=logo-se&mainnav=softwarenav&bottom=bottom-se

I'll have a look at that one, too. Thanks...
Do you use any of the other peripherals of the SM501, too?
(USB, Audio, 8051)

Best greets,

Clemens Koller
