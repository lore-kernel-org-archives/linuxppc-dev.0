Date: Mon, 28 Feb 2000 11:42:37 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000228184237.ZM4016@saguaro.lan>
In-Reply-To: "jjs" <Jerry.Sexton@insignia.com>
        "Re: gdb and multi-threaded applications." (Feb 28,  3:31pm)
References: <038801bf8200$e4e92a00$571170c1@honda.isltd.insignia.com>
To: "jjs" <Jerry.Sexton@insignia.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: gdb and multi-threaded applications.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Feb 28,  3:31pm, jjs wrote:

> >Would it be possible for you to print out the contents of set at this
> >point?  (Go "up" a frame and do "print *set".)
> >
> >>     at ../sysdeps/unix/sysv/linux/sigsuspend.c:48
> >> #2  0x184aa88 in linux_child_wait (pid=-1, rpid=0x7fffe0f0,
> >> status=0x7fffe0f4)
> >>     at linux-thread.c:1338
>
> (gdb) p *set
> $2 = {__val = {0 <repeats 32 times>}}

This looks okay.

> >And I'd like to see what linux_threads_block_mask is at this point too.
>
> (gdb) p linuxthreads_block_mask
> $3 = {__val = {0 <repeats 32 times>}}

This looks okay too.

> >Are you running a proprietary applicaton?  If not, it may be useful at
> >some point for me to get a copy of it and try to reproduce the problems
> >you're seeing myself.
>
> Unfortunately, I am running a proprietory application.

[...]

> I tried running linux-dp under gdb and it works exactly as you  describe, so
> there is no fundamental problem with gdb debugging a program that calls
> pthread_create.

In order for me to be able to go further on this problem, I'll need to
be able to reproduce it on my machine so that I can debug it.  Could
you look at what your proprietary application is doing (with regard to
thread creation) and attempt to create a small program which illustrates
the problem?

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
