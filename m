Message-ID: <3CFF8A74.E17E25D2@mvista.com>
Date: Thu, 06 Jun 2002 11:14:44 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Rick Hunnicutt <rhunnicu@getntds.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: GDB/GDBSERVER and remote Thread Debugging
References: <000a01c20d70$e66e9420$cdf859c7@get.com> <3CFF865B.4C4F8DDA@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry, I was incorrect.  Remote thread debugging has not yet been pulled in by
the upstream GDB.  We have it internally, but it's not in GDB 5.2.  (Mind you
GDB 5.2 does have good local thread debugging.)

--Mark

Mark Hatle wrote:
>
> Probably not the answer you want, but MontaVista's GDB 5.2 version allows remote
> thread debugging.  (We are in the process of releasing GDB 5.2 as an update
> right now.  I don't know for sure when it will be released.)  I don't know if
> the upstream (GNU version) supports that for PPC or not.  I know it does not for
> SH, MIPS, and ARM.
>
> --Mark
>
> Rick Hunnicutt wrote:
> >
> > Will this give thread debugging with GDBSERVER as well or does it still have
> > to be native GDB?
> > >
> > > You will need to be working with GDB version 5.2 or newer to do thread
> > > debugging.
> > >
> > > --Mark
> > >
> > > > I'm looking for a stable GDB/GDBSERVER extension
> > > > suitable for (remote) Debugging multiple threads.
> > > >
> > > > It should also possible to attach already running
> > > > threads.
> > > >
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
