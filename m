Content-Type: text/plain;
  charset="iso-8859-1"
From: Joe Green <jgreen@mvista.com>
To: Michael Habermann <MHabermann@gmx.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Reducing glibc with mklibs.sh
Date: Fri, 26 Oct 2001 10:48:43 -0700
References: <5.1.0.14.0.20011018123155.026b01c0@pop.gmx.de> <5.1.0.14.0.20011024100413.02d78e40@pop.gmx.de>
In-Reply-To: <5.1.0.14.0.20011024100413.02d78e40@pop.gmx.de>
MIME-Version: 1.0
Message-Id: <01102610484300.05612@minotaur>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday 23 October 2001 19:18, Michael Habermann wrote:
> > ppc_8xx-libindex -r interp.o sofini.o soinit.o -o <other_objs> > index
>
> I think there was a typo, the library is not specified.

D'oh.  Yes, you're right.

> Assuming that other_objs is empty in my case, I've used this command:
>
> ppc_8xx-libindex libc-2.2.2.so -r interp.o sofini.o soinit.o > index

Well, that indicates a library with no optional objects.  There's no
point in using the optimizer on such a library.

It's more common to have a library with no required objects.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
