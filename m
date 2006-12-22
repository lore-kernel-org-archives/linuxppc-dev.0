Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.4.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42CB3DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Dec 2006 22:12:35 +1100 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBMBCDI6003829
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Dec 2006 12:12:19 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <458BBD27.1030207@246tNt.com>
Date: Fri, 22 Dec 2006 12:10:31 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [RFC] lite5200b low power mode
References: <20061222105404.GC2481@moe.telargo.com>
In-Reply-To: <20061222105404.GC2481@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Domen Puncer wrote:
> Hi!
>
> I have managed to implement low power mode... well, to some
> degree, at least.
>
> Short description:
> patch u-boot, it's the return from wakeup code. pretty clean.
> 	address is saved at 0x0 (0xc000_0000)
> patch linux with PM-platform_bus-and-late_suspend-early_resume.patch
> 	didn't investigate too much, but it seems to broke mine.
> patch linux with lite5200b_low_power.patch
> 	ugly, with debugging, hacks and whatever
>
> Boot Linux and 'echo mem > /sys/power/state'.
> It won't work on PCI, possibly other devices, PSC0 and FEC seem
> to work ok for me.
>
> It seems to work reliably (checksums match, so ram was in self-refresh)
> when called from boot scripts, but not so when from console prompt.
>
>
> If someone's interested (or maybe wants to play with this during
> holiday? ;-) ), more info follow:
>
>   
Well, I'll have a look, that looks interesting ;)


    Sylvain
