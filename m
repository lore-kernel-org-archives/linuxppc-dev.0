Message-ID: <3858128D.B2A8D870@netx4.com>
Date: Wed, 15 Dec 1999 17:13:33 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Alan Mimms <alan@packetengines.com>
CC: Richard Hendricks <ra6353@email.sps.mot.com>,
        Jim Chapman <jim.chapman@iname.com>, bsimon@ctam.com.au,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <3857F56C.65411CA4@netx4.com> <385807D7.8262398C@email.sps.mot.com> <99121513483409.00750@alan.corp.packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:


> Actually and arguably, "good system design" says precisely the opposite.  If
> you're building up, say, network protocol packets to be DMAed out through a FEC
> you want to be able to touch the area of the packet buffer repeatedly without
> having to do a memory cycle for each "touch".  Cacheable packet buffers are the
> only way to get this performance enhancing behavior.



This is exactly what the Linux kernel does.  It just didn't
seem to be the place to describe what is cached and flushed,
write through, or non-cached.  Take a look at the existing
CPM drivers and see what they do.

A "good system design" is whatever is appropriate for the
application.  Be happy you are using a processor that provides
these flexible options.  Many don't.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
