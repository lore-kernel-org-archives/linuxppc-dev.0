Reply-To: <fabidi@ultsol.com>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: "'Matevz Langus'" <matevz.langus@fortunal.net>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: JTAG debuggers for Motorola 8xx/82xx/85xx
Date: Wed, 9 Jun 2004 23:25:54 -0400
Message-ID: <81C69D96BDD30640952C7A404004AA2501AA04@h0007e95d9fa7.ne.client2.attbi.com>
In-Reply-To: <1086815570.3985.13.camel@n1020>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Matevz,

In the BDI, the 85xx is a different family from the 82xx which is different
from 8xx. The reason for this is that the JTAG connection requires a
different startup sequence, plus a whole different set of core registers....
basically enough work went into building the support into the tool that it
justified charging for a new firmware. You can check from
http://www.abatron.ch/products/xr/aspx/rx/default.htm the list of processors
supported in any given firmware.

The BDI is a very well supported tool, Abatron is very fast on its heals in
providing support and identifying (and fixing) bugs with new processor
families. And you know my opinion is totally unbiased since I work for
Ultimate Solutions.... the north American Rep for Abatron... ;)

I hope people on this list can attest to the support Abatron and Myself have
provided to support their development efforts in North America. Can't
promise amazing things, but it works pretty darn well.... That's marketing
speak.

Fahd Abidi
Field Applications Engineer
Ultimate Solutions, Inc.
=================================================
Professional Development Tools for Embedded Systems
Toll Free: 866-455-3383 x255
Facsimile: 978-926-3091
Email: fabidi@ultsol.com
www: http://www.ultsol.com
FAQ: http://www.ultsol.com/faqs.htm

-----Original Message-----
From: Matevz Langus [mailto:matevz.langus@fortunal.net]
Sent: Wednesday, June 09, 2004 4:13 PM
Subject: JTAG debuggers for Motorola 8xx/82xx/85xx

I see you are discussing about BDI2000 here. Our company used EST Tools
for many years and they were really good but since Windriver bought EST
they suck.

Which JTAG debugger do you suggest for Mot 8xx/82xx/85xx processors?
If possible without stupid licensing model, where every time Motorola
changes partnumber for the same chip new license and a couple k$ are
needed.

I hope to get honest answers as all producers promise amazing things
which aren't really to believe.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
