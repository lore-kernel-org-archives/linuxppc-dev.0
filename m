Date: Thu, 11 Apr 02 10:25:42 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204111725.AA28986@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Then get an OF license

I'm sure most customers would appreciate a lower price for boards without OF
license costs. I also claim that StarMON is better than OF.

> yaboot
> will Just Work and booting from CD will probably just work too.

I plan to write ybboot that will do for PPCStar what yaboot does for OF. Then
I'll just need to convince Debian to include ybboot in addition to yaboot,
which I hope won't be too hard as it's a really tiny and non-invasive bit.

> That's a rather large exageration.  If a vendor doesn't test their
> distribution on a model but is going to claim it works, it's going to
> upset someone when they find out it doesn't.

Of course it must be tested. But it should be one distribution, not 20 slightly
different, identical-except-for-one-byte-machine-code ones. Testing will be a
lot easier this way too.

> Did you have to strip the ELF header off or no?

I just loaded the zImage file as it was generated at 0x7F0000 so that the
actual code ended up at 0x800000, and started it at 0x800000.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
