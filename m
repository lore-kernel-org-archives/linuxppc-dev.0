Date: Fri, 17 Aug 2001 12:28:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4
Message-ID: <20010817122829.D556@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010816172318.F1E97FE57@hostme.bitkeeper.com> <20010816103216.H26735@cpe-24-221-152-185.az.sprintbbd.net> <15228.44957.167444.619604@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15228.44957.167444.619604@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 17, 2001 at 03:46:05PM +1000, Paul Mackerras wrote:
> Tom Rini writes:
>
> > > ChangeSet@1.272, 2001-08-16 10:22:52-07:00, trini@opus.bloom.county
> > >   More minor changes to let !CONFIG_6xx compile again, arg!  Who
> > >   knew the _{set,get}_L2CR bits were so heavily embedded? :)
> >
> > Okay.  What I'm about to do in 2_4_devel, is try and rip these out a bit
> > more cleanly.  Right now, outside of platform-specific files, kernel/sysctl.c
>
> Hmmm.  I think this is a situation where you need to realize that
> you're digging yourself into a hole, stop, sit back and think about it
> a bit more.

Well, this does let us kill the #ifs in arch/ppc/kernel/setup.c in both
trees, and will protect against the future to boot.  It also removes the
Power3/4 kludge.  Thanks, done. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
