Date: Sat, 15 May 1999 17:14:44 -0600
From: Cort Dougan <cort@ppc.kernel.org>
To: Tom Rini <tmrini@ntplx.net>
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: VGER kernels
Message-ID: <19990515171444.A7870@attis.cs.nmt.edu>
References: <Pine.LNX.4.05.9905151011150.651-100000@pc.wackyland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.9905151011150.651-100000@pc.wackyland.com>; from Tom Rini on Sat, May 15, 1999 at 10:13:34AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'd very much recommend no-one uses 2.3.x for a while.  It's likely unstable
and definitely unable to compile in most configurations for PowerPC.

I'll try to backport the important stuff to 2.2.x but that's a lot of work
and I don't know how well I'll be able to keep up with it.

} I've noticed a few mails recently about problems compiling 2.3.x from
} vger.  I think it should be pointed out that you most likely (Unless Cort
} or Paul wishes to contradict me) don't want to be running 2.3.x on your
} machine for day to day use.  It's the devel branch, and it subject to
} crashing and other problems.  You will most likekly want (and I hope Cort
} and/or Paul will keep up w/ the 2.2.x branch as well..) to run your cvs
} updates as:

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
