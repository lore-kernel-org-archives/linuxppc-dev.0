Date: Mon, 10 Nov 2003 13:32:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linas@austin.ibm.com
Cc: Christian <evil@g-house.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc32 lockups with 2.6
Message-ID: <20031110203252.GD8584@ip68-0-152-218.tc.ph.cox.net>
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de> <20031110125044.A22030@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031110125044.A22030@forte.austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 10, 2003 at 12:50:44PM -0600, linas@austin.ibm.com wrote:
>
> On Thu, Nov 06, 2003 at 10:34:26PM +0100, Christian wrote:
> >
> > as nobody seems to answer,
> >
> > yes, i know, if the problem does not occur to other people, it's not
> > worth fixing it. and PReP machines seem to be some kind of "exotic"
> > (read: outdated) anyways. but i don't have the skills fixing it :-(
> >
> > so, if at least someone could point me to something i might have
> > forgotten to look at, or how to get an oops message out of this here.
> > would be nice if it turns out to be a user-error only.
>
> I'd suggest getting the KDB kernel patches, and then poking around to
> see what the system was doing when it locked up.  What were the stack traces?
> does it always lock up in the same routine?  What line of code was it
> executiing when it did that?

It should be easier to get KGDB working here actually.  I know in the
not too distant past I've hooked KGDB up to my Powerstack for some
quick testing.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
