Subject: Re: Interfaces supported on PPC860?
To: DBrown03@harris.com ("Brown, David (dbrown03)")
Date: Fri, 7 Apr 2000 11:12:54 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org ('linuxppc-embedded@lists.linuxppc.org')
In-Reply-To: <BE1C564723B3D21191FD0000F840E39801D81499@rfcmx2.rfc.comm.harris.com> from "Brown, David (dbrown03)" at Apr 06, 2000 12:04:28 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000407011254.DE97D3C9CA@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Brown, David (dbrown03)" writes:
> If I should be reading some existing document or web-page instead of asking
> the list, please kindly redirect me.

It doesn't answer all of your questions directly, but a good starting point
is the HOWTO at:
    http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO.html

> Interfaces of the existing board:

Is the existing board a custom one, or does it have a name you could run past
us?  Most of the existing off-the-shelf boards are already well supported.

A couple of comments on stuff I know about:

> Flash: 1MB(AMD) + 8MB(Intel)

Fitting a compressed kernel + root filesystem + application in 1MB might be a
bit of a challenge, but it should be doable provided your app isn't large.
If you don't need to write to flash from your application, you don't need a
driver for it.

> SCC1: Ethernet (external PHY), using RXD, TXD, RTS, CTS, CD, and RCLKI
>       (ethernet chip supplies 20MHz clock on RCLKI)

What type of PHY are you using?  You may need some minor tweaks if it's not
already supported, but the PHY interface is pretty standard so it shouldn't be
hard.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
