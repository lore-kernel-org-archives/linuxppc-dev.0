Message-ID: <DEA23DB61B62D4118B5900508B323B84012CC7D9@OPENMAIL>
From: Jeremy Bowen <Jeremy.Bowen@opennw.com>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problems with MMU: address translation for 0xXXXXXXXX failed 
Date: Thu, 15 May 2003 15:43:15 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> You may be wrong again.
> Are you absolutely sure that it's  a  bug  in  the  firmware?

The old firmware doesn't work. The new firmware does. I'd call that a bug.

> Please
> consider  the possibility that the firware was designed for a version
> of the Linux kernel which showed a  different  behaviour.  You  might
> want  to  check  when  the PTBASE support first appeared in the Linux
> kernel and relate this to BDI2000 firmware releases.

>From the BDI release notes it appears that this was corrected in BDI2000
firmware v1.10 (2 Nov 2001) - clearly listed as a bug-fix. This corresponds
approximately with the release of Linux kernel v2.4.13

BDI v1.09 (11 Aug 2001) release notes indicates support for changed Linux
MMU behaviour coinciding with Linux kernel v2.4.7/8

Therefore, as v1.09 doesn't work on my kernel and v1.12 does, this fix in
v1.10 was made to correct behaviour that has been present in kernels since
v2.4.12 if not before.

I suspect that had I upgraded only to v1.10 I would also have solved the
issues as the release notes do not indicate any bug-fixes since v1.10

> Let's put it straight: either you (or  your  company)  payed  for  an
> extension  of  your  software  support,  or  your  copy of the bdiGDB
> software version 1.12 is illegal. Period.

Wrong. You have been unable to demonstrate anything illegal.
I still believe I'm completely and entirely innocent here. I have acted in
good faith and cannot find any evidence of a license agreement you say I've
breached.

* I can find no documentation anywhere about what the "software support"
consists of or what it entitles me to. Email ? 24 hour phone ? Feature
requests ? Updates ?

* There is nothing to indicate that firmware upgrades are time limited to
only 1 year. Nor on the other hand is there anything to indicate that I'm
entitled to any firmware updates at all. There is simply no information
whatsoever.

* The only licensing agreement anywhere was apparently on the "packaging" of
the original floppy (long since discarded), which could easily be argued
applied only to the software on that floppy. (Shrinkwrap licenses are a
whole other issue anyway)

* There is nothing to indicate that the firmware updates are licensed
software items nor that they are only available to purchasers of extended
licenses.

* There is nothing on the Abatron web-site which indicates that extended
support is even available to be purchased. We received no information to
this effect when we purchased the BDI2000's either.

* I have received firmware updates in their original form and without
modification and there is nothing either accompanying them nor contained
within to suggest that their use is restricted.

* Driver/BIOS/firmware updates are standard industry practices and, without
a single exception I can think of, are provided free and unencumbered by
restrictive licenses. I had no reason (nor any evidence) to think that this
should be any different for the BDI.

* Wolfgang, you even told me to use a newer version of the firmware without
indicating any issues with licenses.

All of the above may well be an oversight by Abatron but for you to suggest
that what I have done is illegal is just plain wrong. All we have is your
un-supported opinion that I'm not supposed to be running v1.12 firmware
(which I reject).

It is Abatron's responsibility to ensure that, if their software has license
restrictions, these are distributed with the software, but as there are no
such restrictions, I fail to see what you're complaining about.

Jeremy Bowen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
