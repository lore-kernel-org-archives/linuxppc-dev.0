Mime-Version: 1.0
Message-Id: <v04220800b6a23b70189a@[10.0.0.42]>
In-Reply-To: <20010203030351.28012.qmail@web1003.mail.yahoo.com>
References: <20010203030351.28012.qmail@web1003.mail.yahoo.com>
Date: Sat, 3 Feb 2001 15:24:45 -0800
To: Dan Bethe <dan_bethe@yahoo.com>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: powerbook doubles as a frying pan
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:03 PM -0800 2/2/01, Dan Bethe wrote:
>>  However, from what I've heard the G4 sensor is essentially useless.
>>  On my own dual processor 500, a MacOS temperature readout utility
>>  consistently tells me that one processor is 24 degC (or more) cooler
>>  than the other.  Both CPUs are the same die revision of course.
>
>	Maybe one is being used more than the other.  :)  That would often be
>the case.

The construction of the heatsink used in the dual processor G4s
guarantees that the two processors should always be about the same
temperature.  They're thermally coupled by a very thick chunk of
aluminum.

Besides, the difference between the readings remains the same whether
the machine is doing nothing or crunching RC5 full blast (the MacOS
RC5 client does use both CPUs).

>	One is that the Wallstreet II series had a revision that had a
>motherboard bus somewhere around 83 MHz and was way hotter than the
>rest, which were often at 66 MHz.  I'm pretty sure the cpu speed was
>292 MHz on that faster motherboard.  They had to lower the motherboard
>bus for subsequent models because it was too hot.

That was the original Wall Street series, not Wall Street II (which
was actually codenamed "PDQ" by the way).  The 233 MHz WS had a 66
MHz bus but the 250 and 292 MHz WS models had 83 MHz busses.

But the bus wasn't the reason they got so hot.  That was caused by
the use of first generation 0.29 micron Motorola G3 processors (all
that was available), and inadequate cooling.  Later versions of the
G3 were process shrunk and use a lower core voltage, resulting in
less than half the power consumption at the same clock.  And later
versions of the PowerBook G3 got better cooling technology.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
