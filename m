Date: Tue, 18 Jul 2000 15:37:13 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Nathan Ingersoll <ningerso@d.umn.edu>
cc: Paul Schinder <schinder@pobox.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Malloc bug?
In-Reply-To: <Pine.SO4.4.02.10007181627250.11229-100000@ub.d.umn.edu>
Message-ID: <Pine.LNX.3.96.1000718153619.7613E-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 18 Jul 2000, Nathan Ingersoll wrote:

>
> On Tue, 18 Jul 2000, Paul Schinder wrote:
>
> > At 3:40 PM -0500 7/18/00, Nathan Ingersoll wrote:
> > >I've been working on a GTK program for a while now, and I've been
> > >experiencing segfaults within malloc. I was under the impression that
> > >malloc should always return successfully (at least that's what the man
> > >page says).
> >
> > No, it shouldn't.  If there's no memory left, it will return NULL.
> > Software should be checking for this.
>
> Right, but it's not returning at all. It's segfaulting inside the malloc
> function before it returns anything.

See my comments in the message I sent a few minutes ago.  Any of the #3
problems with free() can cause this.


Later,
David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
