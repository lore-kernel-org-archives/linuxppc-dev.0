Message-ID: <39EBD214.56C034EA@mvista.com>
Date: Tue, 17 Oct 2000 00:14:12 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: minyard@acm.org
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Allowing signal handlers to modify SE and BE
References: <m2lmvoqimb.fsf@c469597-a.grlnd1.tx.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Corey Minyard wrote:

> Is this really the case?  I noticed in the x86 version that setting
> the equivalent of the SE bit is allowed, how does the x86 get away
> with this while the PPC can't?

These bits are optionally supported by processors.  As I recall,
the 601 doesn't but I don't know of any others.  You may find a
processor where they don't have any effect.  I can't think of any
other reason.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
