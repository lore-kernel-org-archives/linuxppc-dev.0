Message-ID: <375C213C.90DBE256@uab.ericsson.se>
Date: Mon, 07 Jun 1999 21:45:00 +0200
From: Leif Lindholm <Leif.Lindholm@uab.ericsson.se>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: udelay not exported to kernel(?)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello

I guess probably most here don't mess around with real time processes,
so this wouldn't be noticed. I may need to in a while though.

Now, the problem is this:
udelay, which is used (at least) in linux/kerne/sched.c:sys_nanosleep
when a process is running in real time mode doesn't seem to be compiled
into the finished kernel (embedded-2.2.5), it is only available in the
loader. This is of course on my own port, but looking at the source
there is no EXPORT_SYMBOL(udelay) there among with the others.

Is this just me, or is it a real problem?

Would a udelay for all ports in ppc/lib/something.S (heavily #ifdef:d if
needed) do it? This being how the string and memory functions have been
exported.

Any thoughts?

Grateful for replies

/
	Leif

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
