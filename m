Message-ID: <000b01c48b63$217d9d00$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Andrey Volkov" <avolkov@varma-el.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <856066558.20040825185955@varma-el.com>
Subject: Re: mpc5200 and ddr
Date: Thu, 26 Aug 2004 07:52:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Hello David,
>
> Are you know where I could get example/datasheet which explain
> attachment of DDR memory to mpc5200.
>
> Best of all, if it would be part of
> schematic. Because UM/TM/APP notes, which I found on freescale
> site are VERY foggy about DDR.
>

The part of the design that is probably most important is your PCB
layout, and it's not really practical for anyone to give you a cookbook
solution for that.  As to termination, the BGA package makes many
of the usual techniques unusable or even harmful.  Series termination,
for instance, requires the resistors to be right next to the driver pin.
On a typical BGA layout they'll be more like half way to the DRAM
and work more like a speed bump in a road.  And of course, the
bidirectional data pins can't be terminated this way.

The 5200 gives you a separate buss for SDRAM, so your best bet
is to just tell the layout guy to do that buss first.  These guys take
great pride in understanding signal integrity, he (she) will know what
to do...

Mark C.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
