Date: Tue, 7 Aug 2001 17:21:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: How about a few symlinks.....
Message-ID: <20010807172110.F2399@cpe-24-221-152-185.az.sprintbbd.net>
References: <3B7056AA.EAE5CEE1@mvista.com> <20010807162337.I22821@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010807162337.I22821@mikef-linux.matchmail.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 07, 2001 at 04:23:37PM -0700, Mike Fedyk wrote:
>
> On Tue, Aug 07, 2001 at 04:59:22PM -0400, Dan Malek wrote:
> >
> > While editing some Makefiles I was wondering what people thought
> > of using symlinks to processor dependent files instead of nested
> > ifdefs in Makefiles?
> >
> > For starters, make arch/ppc/kernel/head.S a symlink to the appropriate
> > one in that directory, and derive the name to use from one of the
> > config options.  I thought I would ask before demonstrating the change.
> >
>
> Also, include/asm is just a lymlink to asm-${arch}.

Yes, and ARM goes and makes a few other config-dependant symlinks.  So
there's precidence (and it'd be easy to setup too, more or less).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
