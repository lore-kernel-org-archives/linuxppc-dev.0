Message-ID: <3C1E9E17.96E87D1E@carts.com>
Date: Mon, 17 Dec 2001 17:38:32 -0800
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: Rod Boyce <rod_boyce@DMCWave.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SPI driver?
References: <8D7C5F56B409554D9D46AC22195807F30615F9@exchwenz01.smtp.dmcwave.co.nz>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just got it and found the driver, gracias.  I also got Denx's 2.4.4 kernel and
the SPI driver is missing. I assume this is because the microcode patches are
there and the spi driver doesn't work with them?

Is this the only 8xx or 8260 driver there is?? If there's more I'd like to see
them, just to keep my options open.

Thanks again Rod

Kevin

Rod Boyce wrote:

> Have you tried looking in the <kernel root>/arch/ppc/8xx_io directory there
> is a file there called spi.c This believe it or not is a SPI driver in a
> limited form for the 8XX powerpc cpu.  The kernel I'm using is 2.2.14 from
> ftp://ftp.denx.de <ftp://ftp.denx.de>  this is a very good kernel I suggest
> you look it over at least once.
>
> Rod


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
