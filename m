From: linas@austin.ibm.com
Date: Mon, 10 Nov 2003 17:57:41 -0600
To: Christian <evil@g-house.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc32 lockups with 2.6
Message-ID: <20031110175740.A32176@forte.austin.ibm.com>
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de> <20031110125044.A22030@forte.austin.ibm.com> <3FB01392.60500@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FB01392.60500@g-house.de>; from evil@g-house.de on Mon, Nov 10, 2003 at 11:39:14PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 10, 2003 at 11:39:14PM +0100, Christian wrote:
> linas@austin.ibm.com wrote:
> > I'd suggest getting the KDB kernel patches, and then poking around to
> > see what the system was doing when it locked up.
>
> kdb, hm, i'll see if i can handle this. would some output from gdb help too?

kdb is a built-in kernel debugger. gdb is useless for this case,
although kgdb could be another alternative.

> > What were the stack traces? does it always lock up in the same routine?
>
> the debugger will show, as nothing else showed up and even SysReq was
> not working anymore.

Hmm,  that's bad ... does sysreq work before the lockup?

> > What line of code was it
> > executiing when it did that?

No, I meant in the kernel, the output of the kdb 'bt' command, which
shows what the kernel was doing when kdb was entereed.  But if sysreq
really doesn't work, then theres a chance that kdb won't either, and
that means ... hmm...

--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
