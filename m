Mime-Version: 1.0
Message-Id: <p04320400b59a741412fc@[10.0.1.44]>
In-Reply-To: <Pine.SO4.4.02.10007181457570.7001-100000@ub.d.umn.edu>
References: <Pine.SO4.4.02.10007181457570.7001-100000@ub.d.umn.edu>
Date: Tue, 18 Jul 2000 16:54:29 -0400
To: Nathan Ingersoll <ningerso@d.umn.edu>, linuxppc-dev@lists.linuxppc.org
From: Paul Schinder <schinder@pobox.com>
Subject: Re: Malloc bug?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 3:40 PM -0500 7/18/00, Nathan Ingersoll wrote:
>I've been working on a GTK program for a while now, and I've been
>experiencing segfaults within malloc. I was under the impression that
>malloc should always return successfully (at least that's what the man
>page says).

No, it shouldn't.  If there's no memory left, it will return NULL.
Software should be checking for this.

>Any ideas what may be causing this? I don't know if this has
>anything to do with it, but the kernel I was using generated lots of
>vm_do_try_free_pages failed error logs but not necessarily during program
>execution.
>
>---------------------------------------------------------------------------
>|   Nathan Ingersoll             |   Computer Science/Mathematics         |
>|   mailto: ningerso@d.umn.edu   |   University of Minnesota-Duluth       |
>|   http://umn.edu/~ningerso     |   http://www.d.umn.edu                 |
>---------------------------------------------------------------------------
>
>

--
--
Paul Schinder
schinder@pobox.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
