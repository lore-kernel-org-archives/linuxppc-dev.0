Message-ID: <39F47F61.EFBFFCD2@mvista.com>
Date: Mon, 23 Oct 2000 11:11:45 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Dan Malek <dan@mvista.com>, minyard@acm.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Allowing signal handlers to modify SE and BE
References: <Pine.HPX.4.10.10010171019190.18996-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
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
>         Gabriel.

The SE bit is not present on at least some of the IBM PPC 4xx processors.
It is not present on the 405 processors.  It is not present on the 403GCX.
(I did not check the other 403 variants.)

(This doesn't affect the discussion that led to the question about the SE
bit, but I thought I would let people know about the 4xx processors....)

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
