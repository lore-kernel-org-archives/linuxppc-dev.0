Date: Tue, 8 Apr 2003 18:36:30 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: Mark Hatle <fray@mvista.com>
Cc: Erik Christiansen <erik@dd.nec.com.au>, Darin.Johnson@nokia.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc vs. newlib
In-Reply-To: <3E911523.5050607@mvista.com>
Message-ID: <Pine.LNX.4.52.0304081831450.3191@mag.devdep.sysgo.de>
References: <F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com>
 <3E8E31AD.3050302@mvista.com> <20030407014717.GA742@dd.nec.com.au>
 <3E911523.5050607@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 7 Apr 2003, Mark Hatle wrote:

> looks promising.  For a more traditional linux system, glibc is
> truely the only way to do it.  (With special tools you can
> dramatically reduce the size of glibc, but not as far as most people
> would like.)

This kind of size reduction (aka. "optimisation") sounds sort of scary
to me. Glibc is a big and complicated beast (look, for instance, at
the rather loose ties by which the libnss-stuff is held together). You
seem to have some experience here. Can you seriously recommend this
for _production_ software?

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
