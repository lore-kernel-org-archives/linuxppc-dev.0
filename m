Date: Mon, 18 Mar 2002 17:28:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org, Armin <akuster@pacbell.net>
Subject: Re: [PATCH] another for ibm_ocp_enet gzip'd
Message-ID: <20020319002820.GJ3762@opus.bloom.county>
References: <20020315114137.A26609@ecam.san.rr.com> <20020315200558.GG691@opus.bloom.county> <20020315142542.A27043@ecam.san.rr.com> <20020315223140.GA1643@opus.bloom.county> <20020318142507.A6687@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020318142507.A6687@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Mar 18, 2002 at 02:25:07PM -0800, andrew may wrote:
> On Fri, Mar 15, 2002 at 03:31:40PM -0700, Tom Rini wrote:
> > On Fri, Mar 15, 2002 at 02:25:42PM -0800, andrew may wrote:
> > > On Fri, Mar 15, 2002 at 01:05:58PM -0700, Tom Rini wrote:
> > > > On Fri, Mar 15, 2002 at 11:41:37AM -0800, andrew may wrote:
> > > >
> > > > > 3. added mal.sh to generate a new ibm_ocp_mal.c
> > > >
> > > > This looks very cool.  Can you add in some comments to the shell script,
> > > > and I didn't see any bashisms in there, can you verify it works with
> > > > pdksh or one of the other script shells which can be /bin/sh ?
> > >
> > > I am not sure how I can check against other shells since I don't
> > > have them on my machine. Is sh --posix good enough?
> >
> > It depends on what 'sh' is.
>
> Well I just have bash 2.05a.0(1)-release as a debian package.

Can you apt-get pdksh or ksh at your liesure please?

> Here is a patch for the Config.help and the Makefile

Thanks.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
