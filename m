Subject: Re: 2.4 versus 2.6 patches
From: David Woodhouse <dwmw2@infradead.org>
To: tglx@linutronix.de
Cc: Eugene Surovegin <ebs@ebshome.net>,
	Song Sam <samlinuxppc@yahoo.com.cn>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1090887944.20889.52.camel@thomas.tec.linutronix.de>
References: <20040726134847.84704.qmail@web15214.mail.bjs.yahoo.com>
	 <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain>
	 <20040726163054.GA8872@gate.ebshome.net>
	 <1090883872.20889.11.camel@thomas.tec.linutronix.de>
	 <20040726234904.GA15924@gate.ebshome.net>
	 <1090887944.20889.52.camel@thomas.tec.linutronix.de>
Content-Type: text/plain
Date: Thu, 29 Jul 2004 15:30:07 -0400
Message-Id: <1091129407.4133.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-07-27 at 02:25 +0200, Thomas Gleixner wrote:
> > You missed the point of this discussion. We wasn't talking about some
> > random patches floating around. We were talking about stuff which _is_ in 2.6
> > but not 2.4. Also, we were talking about how mature is 2.6 for production
> > environment and how "dead" is 2.4
>
> I'm well aware of what you were talking in foreground, but I'm also able
> to read the implicit things between the lines.
>
> Quite in contrary: Random patches floating around which do not make
> their way to the place where they should go, _ARE_ part of the problem.

In the case of patches backporting 2.6 features into 2.4, the 'place
where they should go' is /dev/null. It's only pure bug fixes which
should be merged.

We already have a branch in CVS for the 2.4 version of JFFS2, and bugs
are independently fixed there. I've seen no need to do likewise for the
MTD code yet, because most people patching that have been doing so in
order to backport new features rather than to fix bugs.

I don't intend to put new features into 2.4. Where 'new' means developed
after the time I last gave Marcelo an update; not after today. If you
want stuff developed in the last few years (like JFFS2 which mounts in a
relatively sane amount of time) then you should be using 2.6.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
