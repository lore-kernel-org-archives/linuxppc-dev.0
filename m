Date: Tue, 18 Jul 2000 16:30:27 -0500 (CDT)
From: Nathan Ingersoll <ningerso@d.umn.edu>
To: Paul Schinder <schinder@pobox.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Malloc bug?
In-Reply-To: <p04320400b59a741412fc@[10.0.1.44]>
Message-ID: <Pine.SO4.4.02.10007181627250.11229-100000@ub.d.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 18 Jul 2000, Paul Schinder wrote:

> At 3:40 PM -0500 7/18/00, Nathan Ingersoll wrote:
> >I've been working on a GTK program for a while now, and I've been
> >experiencing segfaults within malloc. I was under the impression that
> >malloc should always return successfully (at least that's what the man
> >page says).
>
> No, it shouldn't.  If there's no memory left, it will return NULL.
> Software should be checking for this.

Right, but it's not returning at all. It's segfaulting inside the malloc
function before it returns anything.

---------------------------------------------------------------------------
|   Nathan Ingersoll             |   Computer Science/Mathematics         |
|   mailto: ningerso@d.umn.edu   |   University of Minnesota-Duluth       |
|   http://umn.edu/~ningerso     |   http://www.d.umn.edu                 |
---------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
