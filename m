Date: Mon, 26 Jul 2004 16:49:04 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Song Sam <samlinuxppc@yahoo.com.cn>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4 versus 2.6 patches
Message-ID: <20040726234904.GA15924@gate.ebshome.net>
References: <20040726134847.84704.qmail@web15214.mail.bjs.yahoo.com> <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain> <20040726163054.GA8872@gate.ebshome.net> <1090883872.20889.11.camel@thomas.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1090883872.20889.11.camel@thomas.tec.linutronix.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 27, 2004 at 01:17:52AM +0200, Thomas Gleixner wrote:
> > Hopefully, I can maintain this stuff myself and backport fixes (what I already
> > did for some MTD stuff, btw).
>
> Cool (where are the patches, btw ???).

All stuff I backported into my 2.4.21 tree _are_ from MTD CVS (e.g. write buffer
support for AMD flashes). When I found bugs in MTD layer, I submit patches
through usual channels.

> We would certainly be happy to keep a 2.4 branch of MTD alive if there
> would be any noticable support available instead of whinging about the
> brokenness of the MTD CVS.

Could you point to any e-mail where I was whining about brokenness of MTD CVS?
If not, what was the purpose of your statement?

This is the exact attitude which will not help you to get "any noticeable
support".

> But we certainly do not get any further, when people have patches around
> and complain why we have not included them into MTD CVS by magic
> awareness of the solution.

What is your point? Do you accuse me of not contributing back patches? I always
do this.

You missed the point of this discussion. We wasn't talking about some
random patches floating around. We were talking about stuff which _is_ in 2.6
but not 2.4. Also, we were talking about how mature is 2.6 for production
environment and how "dead" is 2.4

Of course, it's up to maintainer to decide what to backport or not, _nobody_
here asks you or David or anybody else to backport anything.

This is what I _love_ about OSS - I don't depend on any vendor/person/whoever.

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
