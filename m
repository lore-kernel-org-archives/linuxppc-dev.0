Date: Mon, 14 Jun 2004 09:23:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040614162359.GA7798@smtp.west.cox.net>
References: <20040605074341.GA15279@suse.de> <20040608112556.GA21447@suse.de> <20040610001605.GH18212@smtp.west.cox.net> <20040614091530.GA18482@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040614091530.GA18482@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 14, 2004 at 11:15:30AM +0200, Olaf Hering wrote:

>  On Wed, Jun 09, Tom Rini wrote:
>
> > On Tue, Jun 08, 2004 at 01:25:56PM +0200, Olaf Hering wrote:
> >
> > >
> > >  On Sat, Jun 05, Olaf Hering wrote:
> > >
> > > > pomegranate:~# echo dssall | /usr/bin/as -o /tmp/x
> > > > {standard input}: Assembler messages:
> > > > {standard input}:1: Error: Unrecognized opcode: `dssall'
> > > > pomegranate:~# /usr/bin/as -v
> > > > GNU assembler version 2.15.91.0.1 (powerpc-suse-linux) using BFD version 2.15.91.0.1 20040527 (SuSE Linux)
> > > >
> > > >
> > > > *** 2.6 kernels no longer buildcorrectly with old versions of binutils.
> > > > *** Please upgrade your binutils to 2.12.1 or newer
> > > > make: *** [checkbin] Error 1
> > > > make: Target `all' not remade because of errors.
> > >
> > > I talked to Alan, and -many is the correct fix.
> >
> > Does the resulting kernel compile (e.g. on a config where we might try
> > and compile a .S file with 'dssall' in it) ?  I could be missing it, but
> > is -many passed down to gas by something else now?  Otherwise this isn't
> > a correct fix the assembler won't work. :)
>
> Everyone who wants to build the latest and greatest kernel can also
> update binutils, its a no-brainer.

... which does, or doesn't compile a kernel?  Does the latest and
greatest binutils and gcc automatically pass down -many, or does it fail
to compile because the assembler needs -many, but it's not being passed
along.  That's what I asked.

And everyone who wants to build the latest and greatest stable kernel
should probably stick with a stable release of binutils and gcc.  But
that's just my 2 cents. :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
