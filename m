Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0B0E@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Mark Powell'" <medp@primagraphics.co.uk>,
	llandre <r&d@wawnet.biz>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Silicon Motion VGA controllers and PPC architecture
Date: Wed, 12 Nov 2003 12:21:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've had success with a sensoray card connected to a 405.

-----Original Message-----
From: Mark Powell [mailto:medp@primagraphics.co.uk]
Sent: Wednesday, November 12, 2003 12:19 PM
To: llandre
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Silicon Motion VGA controllers and PPC architecture



llandre wrote:

>
> I'm looking for a VGA controller to use with an embedded PPC405-based
> system.
> I had a look at the Silicon Motion chips (712/722) and they seem very
> suited for embedded applications.
> Unfortunately the techical support claims that these chips, because the
> presence of x86 BIOS, support only the x86 architecture. Anybody can
> confirm this?

We have used the 3DM/3DM+ and ran into this problem.
There is no documentation on how to initialise the chip and the
documentation that there is contains little description or explanation
and is just plain wrong in places.

--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, http://www.primagraphics.co.uk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
