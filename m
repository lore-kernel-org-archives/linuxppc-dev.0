Date: Wed, 26 May 2004 09:57:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: curious about BK checkin protocol
Message-ID: <20040526165705.GT6763@smtp.west.cox.net>
References: <Pine.LNX.4.58.0405250909280.14496@localhost.localdomain> <20040525102352.A1329@home.com> <Pine.LNX.4.58.0405260714540.24178@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0405260714540.24178@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 26, 2004 at 07:19:53AM -0400, Robert P. J. Day wrote:

> On Tue, 25 May 2004, Matt Porter wrote:
> > On Tue, May 25, 2004 at 09:12:10AM -0400, Robert P. J. Day wrote:
> > >   i just bk-cloned a fresh copy of the source tree from
> > > http://ppc.bkbits.net:8080/linuxppc-2.5, and once again, had to fix the
> > > file arch/ppc/kernel/ppc_ksyms.c to remove the now-obsolete snippet of
> > > code:
> > >
> > > #if defined(CONFIG_8xx)
> > > EXPORT_SYMBOL(request_8xxirq);
> > > #endif
> > >
> > >   i thought it had been well-established by now that this had to go.
> > > what's the protocol for someone putting these changes into the tree?
> > > just curious.
> >
> > Post a patch.  If it's something that is incorrect in linux-2.5
> > as well, then the patch is expected to be against linux-2.5.
>
> post to this list?  sure, if that's the right place.  the only reason i'm
> obsessed about that little fix as opposed to all the others that are going
> in is that, WRT the most recent BK pull from
> http://ppc.bkbits.net:8080/linuxppc-2.5, that's the *only* thing that
> keeps the kernel from compiling, and letting me build that a kernel that,
> while it loads and runs, admittedly still blows up upon starting init.
>
> while i realize that the current kernel still has user land problems, it
> seems a shame to not at least fix the single minor thing that prevents a
> simple build.

I still like to argue that it's best to loudly blow up than to compile
fine and then die in other ways at run-time (if someone hadn't gotten
the last problem fixed on 8xx I was getting tempted to move what we had
done now up with an #error tossed on top of head_8xx.S pointing people
to what's wrong, etc).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
