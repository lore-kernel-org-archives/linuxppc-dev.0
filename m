Message-ID: <39D816D8.35ED965E@mvista.com>
Date: Mon, 02 Oct 2000 01:02:16 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Dan A. Dickey" <ddickey@charter.net>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ethernet on fads850sar board?
References: <39D7F8FB.9C508CF1@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dan A. Dickey" wrote:

> Any ideas?

Make sure the GP I/O pins are configured properly to be SCC2 Ethernet
control/status lines.  Make sure the BCSR bits enable and properly
configure the PHY (half/full duplex, loopback, etc.).

> (And why do the baud rate generators that feed the ethernet
>  clocks need to run at 2Mhz?)

Ummm, no.....The PHY provides the clocks, they are inputs to port.
I don't know why an external clock would be set to that value.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
