Date: Thu, 11 Apr 2002 10:42:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020411174233.GC19157@opus.bloom.county>
References: <20020411165908.GA19157@opus.bloom.county> <0204111725.AA28986@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204111725.AA28986@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 10:25:42AM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Then get an OF license
>
> I'm sure most customers would appreciate a lower price for boards without OF
> license costs. I also claim that StarMON is better than OF.

I'm not going to attempt to argue either of those points, but I will
argue that if you want things to just work, OF is the least common
denominator :)

> > yaboot
> > will Just Work and booting from CD will probably just work too.
>
> I plan to write ybboot that will do for PPCStar what yaboot does for OF. Then
> I'll just need to convince Debian to include ybboot in addition to yaboot,
> which I hope won't be too hard as it's a really tiny and non-invasive bit.

Have fun, and good luck.

> > That's a rather large exageration.  If a vendor doesn't test their
> > distribution on a model but is going to claim it works, it's going to
> > upset someone when they find out it doesn't.
>
> Of course it must be tested. But it should be one distribution, not
> 20 slightly different, identical-except-for-one-byte-machine-code ones.
> Testing will be a lot easier this way too.

That's a good case to try and argue, but it's not the current case
either.  We don't have 20 slightly different,
identical-except-for-one-byte-machine-code ones, we have 20 different
machines, most of which have roughly the same code for the wrapper
(serial differences).  And the actual kernels are very different.  And
why on earth would you have 20 different distributions.  You'd have 20
different kernel images, but that's because you have 2 different boards.

> > Did you have to strip the ELF header off or no?
>
> I just loaded the zImage file as it was generated at 0x7F0000 so that the
> actual code ended up at 0x800000, and started it at 0x800000.

Oh, so you just skipped over it anyhow.  Most of the boards just dd it
off and load right at 0x800000.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
