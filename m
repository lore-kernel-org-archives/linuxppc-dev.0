Message-Id: <v01530500b79723cda32a@[208.2.106.82]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 8 Aug 2001 12:21:52 -0500
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
From: trag@io.com (Jeff Walther)
Subject: Re: [off topic] switching cpus
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 03:36 8/8/2001, Steven Hanley wrote:>All
>
>I have a 7300/200 which is broken (faulty mother board), a perfectly working
>7200/120 and a 7200/75 to play with, I am wondering is it feasible to pull the
>cpu out of the 7300/200 and put it in the 7200/120 and have everything still
>work? or is this not something that should be played with?

The 7200 does not have a CPU slot, so there is no way physically to plug in
the CPU card from the 7300.  Further, the 7200 chip set (which is a little
different from the 7300 chip set) uses the DRTRY signal which is not
available on the Apple CPU card edge connector (though it is available on
third party upgrades), so even if you could hack the card in, you'd still
need to wire up the DRTRY signal somehow.

(the following isn't relevant, but it is vaguely interesting)
The 7500, 7600 and 7300 (as well as the rest of the x500, x600 PowerSurge
family) uses the Hammerhead memory controller and CPU bus arbiter.  The
7200 Catalyst family uses a different memory controller and CPU bus
arbiter.

Interestingly, I've found some 7200 motherboards use the same ROM as the
x500 family (Apple part numbers 341S0168, 341S0169, 341S0170, 341S0171
while others use a different ROM that is apparently only for the 7200:
341S0106, 341S0107, 341S0108, 341S0109.

The motherboards in question all have the same part number and range from
75 MHz to 110 MHz, so I have not been able to determine any rhyme or reason
to why some of them have one set of ROMs and some have the other set of
ROMs.

x600 family uses 341S0280, 341S0281, 341S0282, 341S0283
x600 Enhanced (Kansas) uses:  341S0380, 341S0381, 341S0382, 341S0383


Jeff Walther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
