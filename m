Subject: Re: CLLF with Hard Hat Lunix "Sending BOOTP requests" problem
To: dan@mvista.com (Dan Malek)
Date: Tue, 19 Sep 2000 13:21:39 +1100 (EST)
Cc: greyham@research.canon.com.au (Graham Stoney), rshaw@graftononline.net,
        linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <39C6C2EF.4606D448@mvista.com> from "Dan Malek" at Sep 18, 2000 09:35:43 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000919022139.ACA8D219@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

Dan Malek writes:
> The "old" one could download over the 10/100 port.  It was an option
> through the test menu.

Sure, the option is there, but I couldn't ever get it to actually work.
Tried real hard too; even with help from EP's tech support I couldn't get it
to go.  Eventually gave up and connected both ports.

> The new one won't download over the 10/100 port, this was in response to
> customers asking for the smallest possible boot rom image.

Sounds like my protestations about 100 Mbps download being broken didn't get
through their tech support firewall at all.  I may have stopped hassling
their tech support about it constantly once our workaround was going, but I
certainly did ask them to fix it.

> > Note that there is a hack in the fec driver which munges the ethernet MAC
> > address for the FEC port by adding 80:00:00 to the number
>
> This will probably remain as the method for finding a MAC address
> for the second port on the CLLF.  Embedded Planet has said they will
> sequentially update the single MAC address in the on-board EEPROM, and
> we can safely do this.

This works fine, so long as the user realises that the MAC address that the
ROM monitor reports isn't exactly the one that the FEC port will use, and
configures their DHCP server correctly.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
