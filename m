Message-ID: <39C6C2EF.4606D448@mvista.com>
Date: Mon, 18 Sep 2000 21:35:43 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: rshaw@graftononline.net, linuxppc-embedded@lists.linuxppc.org
Subject: Re: CLLF with Hard Hat Lunix "Sending BOOTP requests" problem
References: <20000919010525.0A734231@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> Which version of the ROM monitor are you using?  The old one couldn't download
> over the 100 Mbps port, so we had to connect both.  We used the 10 Mbps port
> to download the kernel, and the 100 Mbps port once the kernel comes up.

The "old" one could download over the 10/100 port.  It was an option
through the test menu.  The new one won't download over the 10/100 port,
this was in response to customers asking for the smallest possible boot
rom image.

> Note that there is a hack in the fec driver which munges the ethernet MAC
> address for the FEC port by adding 80:00:00 to the number

This will probably remain as the method for finding a MAC address
for the second port on the CLLF.  Embedded Planet has said they will
sequentially update the single MAC address in the on-board EEPROM, and
we can safely do this.  However, I think it is always wise for anyone that
creates Ethernet devices to request their own MAC addresses from the
IEEE and use those.  It allows flexibility and control during production.

> .........  By the way, they
> didn't _really_ sell you a board with a MAC address ending in all-zero, did
> they?

I have seen prototype and semi-custom boards from Embedded Planet
that have been tested in their engineering department and rushed to
customers (i.e. bypassed the manufacturing floor) arrive with all
zeros in the MAC address (at least the last three bytes).  I forget
the magic rom command to set these.  Call their support staff and
they will straighten it out.


	-- Dan

---

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
