Message-ID: <3C56E5D4.7085BB1C@mvista.com>
Date: Tue, 29 Jan 2002 10:11:32 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C support for 405GP
References: <3C566357.7060307@esd-electronics.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthias Fuchs wrote:
>
> Hello,
>
> is anybody working on the I2C driver for the IBM 405GP ?
> The driver was in the 2.4.2 Kernel from Montavista, but it dissapeared
> from the devel tree a long time ago. I tried to take that old sources
> and merged the i2c stuff into a more recent 2.4 devel kernel. It did not work.
>
> This leads to some questions:
>
> 1) Is anybody currently workig on this issue ?
> 2) Does anybody have a local working i2c driver for the 405 ?
> 3) Is there a special reason why the i2c support dissapeared ?
>
> I read sometime ago on the i2c project site, that they care about the 405
> i2c driver. Is this true ?
>
> Matthias

Yes I do.
1 & 2) yes
3) The I2c drivers are warehoused by the i2c folks.  If you need it ou
can check it out from there.  I am working on coverting the driver to
the ocp format.

-- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
