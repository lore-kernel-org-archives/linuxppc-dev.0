Date: Fri, 15 Mar 2002 15:31:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org, Armin <akuster@pacbell.net>
Subject: Re: [PATCH] another for ibm_ocp_enet gzip'd
Message-ID: <20020315223140.GA1643@opus.bloom.county>
References: <20020315114137.A26609@ecam.san.rr.com> <20020315200558.GG691@opus.bloom.county> <20020315142542.A27043@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020315142542.A27043@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Mar 15, 2002 at 02:25:42PM -0800, andrew may wrote:
> On Fri, Mar 15, 2002 at 01:05:58PM -0700, Tom Rini wrote:
> > On Fri, Mar 15, 2002 at 11:41:37AM -0800, andrew may wrote:
> >
> > > 3. added mal.sh to generate a new ibm_ocp_mal.c
> >
> > This looks very cool.  Can you add in some comments to the shell script,
> > and I didn't see any bashisms in there, can you verify it works with
> > pdksh or one of the other script shells which can be /bin/sh ?
>
> I am not sure how I can check against other shells since I don't
> have them on my machine. Is sh --posix good enough?

It depends on what 'sh' is.

> Here is a patch to mal.sh with some more comments, taking an
> arg of the Mal count, and some spacing fixups.

Looks good.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
