From: linas@austin.ibm.com
Date: Mon, 10 Nov 2003 12:50:44 -0600
To: Christian <evil@g-house.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc32 lockups with 2.6
Message-ID: <20031110125044.A22030@forte.austin.ibm.com>
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FAABE62.4090804@g-house.de>; from evil@g-house.de on Thu, Nov 06, 2003 at 10:34:26PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 06, 2003 at 10:34:26PM +0100, Christian wrote:
>
> as nobody seems to answer,
>
> yes, i know, if the problem does not occur to other people, it's not
> worth fixing it. and PReP machines seem to be some kind of "exotic"
> (read: outdated) anyways. but i don't have the skills fixing it :-(
>
> so, if at least someone could point me to something i might have
> forgotten to look at, or how to get an oops message out of this here.
> would be nice if it turns out to be a user-error only.

I'd suggest getting the KDB kernel patches, and then poking around to
see what the system was doing when it locked up.  What were the stack traces?
does it always lock up in the same routine?  What line of code was it
executiing when it did that?

--linas


>
> i also filed a bug in bugzilla:
> http://bugzilla.kernel.org/show_bug.cgi?id=1494
>
> Thanks for reading,
> Christian.
>
> --
> BOFH excuse #128:
>
> Power Company having EMP problems with their reactor
>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
