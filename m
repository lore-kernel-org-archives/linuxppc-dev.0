Date: Tue, 24 Apr 2001 12:11:35 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
Cc: Cort Dougan <cort@fsmlabs.com>, Alexandre.Nikolaev@matrox.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc little-endian port
In-Reply-To: <3AE4E93E.AC7C788C@mvista.com>
Message-ID: <Pine.HPX.4.10.10104241134560.2724-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 23 Apr 2001, Dan Malek wrote:

>
> Cort Dougan wrote:
> >
> > Why?
>
> Yeah, we really don't care about little-endian.  Like I always
> say, getting a kernel built and booted is the easy part.  The
> entire world runs big endian tools, libraries and applications.
> Making all of that work is a task no one is going to tackle.

Indeed...

> While refreshing my PowerPC history the other day, I found a UISA
> book from 1991.....The Little-Endian Byte Ordering chapter introduction
> has this to say:

1991 ? I though PPC came in 1993. First Power systems were announced and
delivered in 1990 AFAIR.

> Later in the text it states "There are 24 ways to specify the
> ordering of four bytes withing a word, but only two of these
> orderings are sensible."

Indeed the PDP was a nightmare, like VAX floating-point formats BTW...

> I contend there is only one sensible ordering, and we are already
> using it.........

Right, unfortunately so many people have been brainwashed by the
niadne-elttil side and are unable to think on their own.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
