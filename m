Subject: Re: 2.4 versus 2.6 patches
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Eugene Surovegin <ebs@ebshome.net>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Song Sam <samlinuxppc@yahoo.com.cn>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040726234904.GA15924@gate.ebshome.net>
References: <20040726134847.84704.qmail@web15214.mail.bjs.yahoo.com>
	 <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain>
	 <20040726163054.GA8872@gate.ebshome.net>
	 <1090883872.20889.11.camel@thomas.tec.linutronix.de>
	 <20040726234904.GA15924@gate.ebshome.net>
Content-Type: text/plain
Message-Id: <1090887944.20889.52.camel@thomas.tec.linutronix.de>
Mime-Version: 1.0
Date: Tue, 27 Jul 2004 02:25:45 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-07-27 at 01:49, Eugene Surovegin wrote:
> On Tue, Jul 27, 2004 at 01:17:52AM +0200, Thomas Gleixner wrote:
> > > Hopefully, I can maintain this stuff myself and backport fixes (what I already
> > > did for some MTD stuff, btw).
> >
> > Cool (where are the patches, btw ???).
>
> All stuff I backported into my 2.4.21 tree _are_ from MTD CVS (e.g. write buffer
> support for AMD flashes). When I found bugs in MTD layer, I submit patches
> through usual channels.

I would suspect, that MTD would be an usual channel for stuff concerning
MTD. And maybe I'm missing the point again, but your last posting to MTD
is dated from Jan 2003, if "ebshome" || "eugene" are sufficient enough
search strings.

> > We would certainly be happy to keep a 2.4 branch of MTD alive if there
> > would be any noticable support available instead of whinging about the
> > brokenness of the MTD CVS.
>
> Could you point to any e-mail where I was whining about brokenness of MTD CVS?
> If not, what was the purpose of your statement?

References:  <20040726134847.84704.qmail@web15214.mail.bjs.yahoo.com>
<Pine.LNX.4.58.0407261021120.6190@localhost.localdomain>

Cite: "This is quite sad, but not all maintainers do the same. IIRC
networking fixes are still backported to 2.4. <snip> Hopefully, I can
maintain this stuff myself and backport fixes (what I already did for
some MTD stuff, btw)."

You are accusing David of being not as 2.4 friendly as other maintainers
seem to be in your opinion.

> This is the exact attitude which will not help you to get "any noticeable
> support".

You're attitude is exactly what I'm talking of and why I choose this
tone:
"(what I already did for some MTD stuff, btw)."

> > But we certainly do not get any further, when people have patches around
> > and complain why we have not included them into MTD CVS by magic
> > awareness of the solution.
>
> What is your point? Do you accuse me of not contributing back patches? I always
> do this.

I'm just asking where the patches go to. To the usual places ? See
above.

> You missed the point of this discussion. We wasn't talking about some
> random patches floating around. We were talking about stuff which _is_ in 2.6
> but not 2.4. Also, we were talking about how mature is 2.6 for production
> environment and how "dead" is 2.4

I'm well aware of what you were talking in foreground, but I'm also able
to read the implicit things between the lines.

Quite in contrary: Random patches floating around which do not make
their way to the place where they should go, _ARE_ part of the problem.

tglx


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
