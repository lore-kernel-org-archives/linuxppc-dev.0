Message-ID: <20001208171951.96997.qmail@web10407.mail.yahoo.com>
Date: Fri, 8 Dec 2000 09:19:51 -0800 (PST)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: Re: AW: Sound on an iBook?
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        "Halfmann, Klaus" <khalfmann@libra.de>,
        linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


No I2C is as old as the hills, I2C is a philips serial
bus standard for talking to upto 256 devices on the
one two wire bus. It is pretty crappy simple & slow &
philips generally used it to talk to digital tuners on
radios.


It is also commonly used in embedded stuff, I wrote a
driver for apples tv tuner card on a performa 630 when
I was working for them.

I didn't talk i2c directly but talked to the cuda
manager on the mac os, however, I made a fake i2c bus
via 2 pins on the paralell port of a pc.

If you want to know more about this look for specs on
the cuda chip if you can find them. However I suspect
a
few things have changed since I did my stuff since
Apple loves moving asics around to keep chip designers
mentally masturbating :-).

--- Christof Petig <christof.petig@wtal.de> wrote:
>
> Iain Sandoe wrote:
>
> > duh! just read the whole thread...
> >
> > [...]
> > > Christof could always resort to petitioning
> Apple to release the specs, or
> > > digging though Darwin source code to discover
> the secret.
> >
> > the chip specs are freely available:
> >
> >
>
http://www.micronas.com/documentation/data_sheet/dac3550a_1ds.pdf
> >
> > Ben H might know something about driving the iBook
> i2c busses - I think that
> > they are the new Apple "cereal" style which are
> also present on the PCI host
> > bridges... but not quite sure.
>
> The link is dead, but
>
http://www.micronas.com/products/documentation/consumer/dac3550a/index.php
> works for me well.
>
> Thank you very much for this information!
>
> Christof
>
>
>


=====
D.J. Barrow Linux for S/390 kernel developer
eMail: djbarrow@de.ibm.com,barrow_dj@yahoo.com
Phone: +49-(0)7031-16-2583
IBM Germany Lab, Schönaicherstr. 220, 71032 Böblingen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
