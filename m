Message-ID: <39C6D21D.60A8D525@mvista.com>
Date: Mon, 18 Sep 2000 22:40:29 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: rshaw@graftononline.net, linuxppc-embedded@lists.linuxppc.org
Subject: Re: CLLF with Hard Hat Lunix "Sending BOOTP requests" problem
References: <20000919022139.ACA8D219@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> Sure, the option is there, but I couldn't ever get it to actually work.

Hmm...I guess I was just lucky.

> ... Eventually gave up and connected both ports.

I did too, because the 10 Mbit had the "autostart" option.  Just
one menu key and you are off and running.

> Sounds like my protestations about 100 Mbps download being broken didn't get
> through their tech support firewall at all.

Well, to be a little fair, that was kind of an engineering hack that
was never intended to be "supported".  I am not trying to justify
their responses they may have given to you, but considering it was
never documented as a feature......

The hardware worked, there was a documented method for downloading
over the Ethernet (although it was the 10 Mbit port), and connecting
two cables solved the "problem" for Linux.

> This works fine, so long as the user realises that the MAC address that the
> ROM monitor reports isn't exactly the one that the FEC port will use, and
> configures their DHCP server correctly.

Again, this is something unique to the Linux driver, so it is probably
up to us (me :-) to ensure it is documented somewhere more clearly.
At least it is printed during boot up, which is usually the way I
find the MAC addresses on most systems anyway.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
