Date: Wed, 26 May 2004 07:19:53 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: curious about BK checkin protocol
In-Reply-To: <20040525102352.A1329@home.com>
Message-ID: <Pine.LNX.4.58.0405260714540.24178@localhost.localdomain>
References: <Pine.LNX.4.58.0405250909280.14496@localhost.localdomain>
 <20040525102352.A1329@home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 25 May 2004, Matt Porter wrote:

> On Tue, May 25, 2004 at 09:12:10AM -0400, Robert P. J. Day wrote:
> >
> >   i just bk-cloned a fresh copy of the source tree from
> > http://ppc.bkbits.net:8080/linuxppc-2.5, and once again, had to fix the
> > file arch/ppc/kernel/ppc_ksyms.c to remove the now-obsolete snippet of
> > code:
> >
> > #if defined(CONFIG_8xx)
> > EXPORT_SYMBOL(request_8xxirq);
> > #endif
> >
> >   i thought it had been well-established by now that this had to go.
> > what's the protocol for someone putting these changes into the tree?
> > just curious.
>
> Post a patch.  If it's something that is incorrect in linux-2.5
> as well, then the patch is expected to be against linux-2.5.

post to this list?  sure, if that's the right place.  the only reason i'm
obsessed about that little fix as opposed to all the others that are going
in is that, WRT the most recent BK pull from
http://ppc.bkbits.net:8080/linuxppc-2.5, that's the *only* thing that
keeps the kernel from compiling, and letting me build that a kernel that,
while it loads and runs, admittedly still blows up upon starting init.

while i realize that the current kernel still has user land problems, it
seems a shame to not at least fix the single minor thing that prevents a
simple build.

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
