Message-ID: <8D7C5F56B409554D9D46AC22195807F3061601@exchwenz01.smtp.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@DMCWave.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: 8xx SPI drivers
Date: Wed, 19 Dec 2001 12:17:24 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I have written a generic SPI driver that copes with most hardware
idiosyncrasies MSB first or LSB first this is all available in the 8xx SPI
code I then provide an interface for other drivers to call this driver after
selecting the device to do the SPI transaction.  I also allow users to
interface directly to the SPI device change clocking parameters and let the
user take care of selecting the SPI device this then is a very flexible
device that any SPI device can use.  It is also a load-able module sorry
although having done it once I could recreate the code given the inclination
some hardware, a debugger, (depending on ownership of the driver money,) and
time.

Regards,
Rod

		-----Original Message-----
		From:	Dan Malek [mailto:dan@embeddededge.com]
		Sent:	Wednesday, 19 December 2001 11:57
		To:	Navin Boppuri
		Cc:	Kevin Fry; linuxppc-embedded@lists.linuxppc.org
		Subject:	Re: 8xx SPI drivers


		Navin Boppuri wrote:

		> I have no website of my own to put this stuff on yet.

		Just ask to post it on penguinppc.org.  There is an embedded
section
		there.....but why do you want to post something like this?
I mean,
		we don't post any of the other drivers or code we do
anywhere but in
		the sources themselves.

		> Also, I would like to thank Alex for cleaning up my driver
and for
		> actually using it.

		Keep in mind that SPI designs are very dependent upon the
board/product
		design.  Many of the systems that use SPI have external
hardware for
		device selection and control.  The generic driver is
suitable for clocking
		bits in/out but often isn't sufficient to make everything
work.  Due to the
		timing of SPISEL, I sometimes had to just write a software
bit-toggle function
		to make it work.

		Thanks.


			-- Dan


		** Sent via the linuxppc-embedded mail list. See
http://lists.linuxppc.org/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
