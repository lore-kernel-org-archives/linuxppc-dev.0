Subject: RE: 8xx SPI drivers
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 19 Dec 2001 12:03:46 -0600
Message-ID: <D3A72C5007329A4F991C0DD87202259F0EAFB0@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

This was in response to a request by Kevin in a previous mail. I did
have this driver on a website and the link was included in PowerPC
Embedded HOWTO maintained by Graham then. But I dont have that server up
anymore and the link is not up to date.

And yes, you were right about the spi interface being very specific. But
I do feel that it makes sense for anyone starting to make spi work with
their hardware to look at some previous work. I wrote this driver
looking at your code for the i2c and some spi work done by Tobias
Otto-Adamczak.

Thanks,
Navin.

-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Tuesday, December 18, 2001 4:57 PM
To: Navin Boppuri
Cc: Kevin Fry; linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx SPI drivers


Navin Boppuri wrote:

> I have no website of my own to put this stuff on yet.

Just ask to post it on penguinppc.org.  There is an embedded section
there.....but why do you want to post something like this?  I mean,
we don't post any of the other drivers or code we do anywhere but in
the sources themselves.

> Also, I would like to thank Alex for cleaning up my driver and for
> actually using it.

Keep in mind that SPI designs are very dependent upon the board/product
design.  Many of the systems that use SPI have external hardware for
device selection and control.  The generic driver is suitable for
clocking
bits in/out but often isn't sufficient to make everything work.  Due to
the
timing of SPISEL, I sometimes had to just write a software bit-toggle
function
to make it work.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
