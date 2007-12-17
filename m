Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8D58DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Dec 2007 02:22:24 +1100 (EST)
Message-ID: <4766940E.4090801@freescale.com>
Date: Mon, 17 Dec 2007 09:21:50 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: USB configuration
References: <14192347.post@talk.nabble.com>	<BLU106-W40541C7A5C29E0CF526F13CA6F0@phx.gbl>	<14206951.post@talk.nabble.com>	<BLU106-W35DC430E02A0A1798D8B95CA650@phx.gbl>
	<14370084.post@talk.nabble.com>
In-Reply-To: <14370084.post@talk.nabble.com>
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

Misbah khan wrote:
> I have configured for mass storage device still i am not getting the debug
> msg that the kernel has detected the pen drive (after i connect the pen
> drive ).
> 
>   " Initializing USB Mass Storage driver...
>      usbcore: registered new driver usb-storage
>      USB Mass Storage support registered. 
>   "

Did you get any output indicating that the USB controller was found and 
initialized?  This *is* a PCI-based OHCI controller you're trying to 
use, and not the CPM USB, right?  Do other PCI devices work?

-Scott
