Date: Tue, 17 Oct 2000 10:25:12 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
cc: minyard@acm.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Allowing signal handlers to modify SE and BE
In-Reply-To: <39EBD214.56C034EA@mvista.com>
Message-ID: <Pine.HPX.4.10.10010171019190.18996-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 17 Oct 2000, Dan Malek wrote:

> > Is this really the case?  I noticed in the x86 version that setting
> > the equivalent of the SE bit is allowed, how does the x86 get away
> > with this while the PPC can't?
>
> These bits are optionally supported by processors.  As I recall,
> the 601 doesn't but I don't know of any others.  You may find a
> processor where they don't have any effect.  I can't think of any
> other reason.

Slight correction: the 601 does have the SE bit but not the BE bit. The
other important difference of the 601 is that it handles debug exceptions
differently (different vector etc...).

So at least the SE bit is present on all processors.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
