Date: Wed, 21 Aug 2002 17:54:42 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: John Fisher <John.Fisher@nec.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cygwin and embedded linux
In-Reply-To: <000301c248e8$9a2ce040$37d34c93@neca.nec.com.au>
Message-ID: <Pine.LNX.4.40.0208211747420.7745-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 21 Aug 2002, John Fisher wrote:

> Is anyone seriously trying to do embedded Linux development for power PC
> using Cygwin as the host?

We will do it for Elinos 3.0. There aren't any release dates fixed,
unfortunately.

Actually, my personal opinion on that matter is that I'm not very fond
of using Windows for a Linux kernel development platform. Doing --
ideally pure ANSI-C/C++ -- application development is a different
story. Thus, I feel it is much more sane to split it right there, if
you must:  develop application code whereever you like, but compile
your kernel and integrate your project on Linux.

Just my $.02,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions GmbH     mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
