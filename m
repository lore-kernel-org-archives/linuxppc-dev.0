Message-ID: <3DC7AC62.6040409@iram.es>
Date: Tue, 05 Nov 2002 12:32:50 +0100
From: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IDE on LongTrail
References: <Pine.GSO.4.21.0211051111270.27681-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> According to the IBM LongTrail schematics, PINT[CD] on the W83C553 are
> connected to EXT_INT[56] on the Apple Hydra, which are OpenPIC inputs.
> The connections are called `IDE_NM_INT_P/S' and 'IDE_NM_INT_S'. So it should be
> possible, unless Tatung changed that.

Ok, in this case. look at page 125. You have to set bit 11 (LEGIRQ) to
route the interrupts to IRQC for both channels. You can only separately
route each channel (IRQC for channel 0, IRQD for channel1) if you channel
1 in legacy mode it seems. That's at least what I understand.

>
> Will do some more W83C553 doc parsing soon :-)

Parsing is nothing; you also have to interpret the oracle ;-)

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
