To: Gabriel Paubert <paubert@iram.es>
Cc: Dan Malek <dan@mvista.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Allowing signal handlers to modify SE and BE
References: <Pine.HPX.4.10.10010171019190.18996-100000@gra-ux1.iram.es>
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 17 Oct 2000 09:55:48 -0500
In-Reply-To: Gabriel Paubert's message of "Tue, 17 Oct 2000 10:25:12 +0200 (METDST)"
Message-ID: <m2zok3frez.fsf@c469597-a.grlnd1.tx.home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert <paubert@iram.es> writes:

> On Tue, 17 Oct 2000, Dan Malek wrote:
>
> > > Is this really the case?  I noticed in the x86 version that setting
> > > the equivalent of the SE bit is allowed, how does the x86 get away
> > > with this while the PPC can't?
> >
> > These bits are optionally supported by processors.  As I recall,
> > the 601 doesn't but I don't know of any others.  You may find a
> > processor where they don't have any effect.  I can't think of any
> > other reason.
>
> Slight correction: the 601 does have the SE bit but not the BE bit. The
> other important difference of the 601 is that it handles debug exceptions
> differently (different vector etc...).
>
> So at least the SE bit is present on all processors.
>

Yes, I believe the SE bit is required, but I don't have my PPC manual
with me right now.  But that shouldn't hurt allowing the bits in.

I was actually kind of looking for the person that originally put the
comment in.  I was thinking that maybe I was missing something and
this would cause a problem.  I haven't seen any, but you never know.
If it caused problems for others, that would be a good reason to not
put it into the mainstream kernel code :-).

-Corey

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
