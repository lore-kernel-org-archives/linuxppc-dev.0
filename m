Message-ID: <3AC8ED90.54885AAF@corelatus.com>
Date: Mon, 02 Apr 2001 23:22:24 +0200
From: Thomas Lange <thomas@corelatus.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MII PHY support?
References: <3AC76542.A4D27697@bigwig.net> <3AC8BA81.3BC77AC4@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Maybe we should just move this into a separate source file instead of
> making a big configuration mess of the FCC Ethernet driver.  I'm about
> to do that for some 8xx FEC functions as well.

We have a custom board (GTH) with an 860 using the SCC and the FEC for
ethernet, so we have two transceivers on board.
To support auto neg. and full duplex on the SCC, we need to be able to
communicate with both transceivers. Since this communication is done
on the same MDIO pins, it would be nice to move the code out of the
fec driver and make it possible to use for scc ethernet too.

/Thomas Lange/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
