Date: Mon, 9 Jul 2001 08:17:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Rugen <jprugen@earthlink.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: RTC and SCSI for PowerStack/2.4.6 Kernel
Message-ID: <20010709081700.I825@opus.bloom.county>
References: <Pine.LNX.4.05.10107091706100.15110-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10107091706100.15110-100000@callisto.of.borg>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 09, 2001 at 05:08:50PM +0200, Geert Uytterhoeven wrote:
> On Mon, 9 Jul 2001, Tom Rini wrote:
> > On Mon, Jul 09, 2001 at 07:38:58AM -0700, Jeff Rugen wrote:
> > > I've booted 2.4.6 successfully 4 times so far -- 2 times it crashed with
> > > SCSI timeouts, and 2 times it hung for unknown reasons (with no oops output
> > > or anything).  The second time it might have been framebuffer or network
> > > related (I'd installed clgenfb, changed video modes, and then did 'dir' in
> > > an ftp session to a site with a long directory listing twice -- the second
> > > time it hung).
> >
> > Did you do any fixes/cleanups to clgenfb?  I took a stab and trying to
> > re-do your PReP fixes in it a while back, but I don't think it ever got
> > into the main tree.
>
> There's still an off-by-one error in the PCI probing.

Yeap. :)  Dan Malek found that one a while ago too, but I keep forgetting I've
got it sitting around.  Will this patch be going towards Linus anytime soon?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
