From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15477.22880.141084.768742@zaphod.musenki.com>
Date: Thu, 21 Feb 2002 14:32:32 -0600
To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: custom mpc8240 student project (long)
In-Reply-To: <C08678384BE7D311B4D70004ACA371050B7632E4@amer22.avnet.com>
References: <C08678384BE7D311B4D70004ACA371050B7632E4@amer22.avnet.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kerl, John writes:

> #3, socketed flash tends to wear out -- we've had a lot of
> frustration with metal fatigue on the flash pins and/or socket
> pins.  When you use JTAG, you aren't wearing out your flash
> pins by popping them in & out of sockets, in & out of the flash
> programmer, dropping them, etc.

I can't begin to endorse just how true this is.  The top of my
keyboard/desk are littered with tiny dead flash parts.  Our (8245)
boards have had the sockets re-soldered at least 3 times each, due
entirely to handling stress.

Not mentioned is the fact that the pins eventually oxidize.

We'ld have used the COP (JTAG) port to program the flash, but the
proto board had the flash bus wired backwards (all to easy to do,
apparently), and the JTAG probe can't identify the flash parts.

> #4, board testers such as this don't just program flash -- they
> can also do hardware verification, e.g. finding shorts, opens
> etc.  This is invaluable with new hardware.

A BDM or JTAG probe should also allow you to get the internal state of
the CPU, which makes finding where your program went wrong possible,
if not easier.

Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
