Message-ID: <8D7C5F56B409554D9D46AC22195807F30615F9@exchwenz01.smtp.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@DMCWave.com>
To: "'Kevin Fry'" <kevin@carts.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: SPI driver?
Date: Tue, 18 Dec 2001 13:58:08 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Have you tried looking in the <kernel root>/arch/ppc/8xx_io directory there
is a file there called spi.c This believe it or not is a SPI driver in a
limited form for the 8XX powerpc cpu.  The kernel I'm using is 2.2.14 from
ftp://ftp.denx.de <ftp://ftp.denx.de>  this is a very good kernel I suggest
you look it over at least once.


Rod

		-----Original Message-----
		From:	Kevin Fry [mailto:kevin@carts.com]
		Sent:	Tuesday, 18 December 2001 13:49
		To:	linuxppc-embedded@lists.linuxppc.org
		Subject:	SPI driver?


		Is there an MPC8260 SPI driver out there for Linux?  It
wouldn't be
		terribly hard to write one on my own, but why re-invent the
wheel?

		A link to an 8xx driver would be almost as good. The only
one I've found
		so far has been SPI over a PC's parallel port. heh

		Thanks

		Kevin Fry


		** Sent via the linuxppc-embedded mail list. See
http://lists.linuxppc.org/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
