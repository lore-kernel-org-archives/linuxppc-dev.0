Subject: Re: 2.4 versus 2.6 patches
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Eugene Surovegin <ebs@ebshome.net>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Song Sam <samlinuxppc@yahoo.com.cn>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040726163054.GA8872@gate.ebshome.net>
References: <20040726134847.84704.qmail@web15214.mail.bjs.yahoo.com>
	 <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain>
	 <20040726163054.GA8872@gate.ebshome.net>
Content-Type: text/plain
Message-Id: <1090883872.20889.11.camel@thomas.tec.linutronix.de>
Mime-Version: 1.0
Date: Tue, 27 Jul 2004 01:17:52 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-07-26 at 18:30, Eugene Surovegin wrote:
> On Mon, Jul 26, 2004 at 10:27:52AM -0400, David Woodhouse wrote:
> > Because nobody's really that interested in it. For what it's worth, I've
> > abandoned all pretence of continuing to support 2.4 in the MTD/JFFS2 CVS
> > tree.
>
> This is quite sad, but not all maintainers do the same. IIRC networking fixes
> are still backported to 2.4.

Maybe not all maintainers suffer from continous lack of collaboration
and community feedback.

> Hopefully, I can maintain this stuff myself and backport fixes (what I already
> did for some MTD stuff, btw).

Cool (where are the patches, btw ???).

We would certainly be happy to keep a 2.4 branch of MTD alive if there
would be any noticable support available instead of whinging about the
brokenness of the MTD CVS.

But we certainly do not get any further, when people have patches around
and complain why we have not included them into MTD CVS by magic
awareness of the solution.

tglx


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
