Date: Tue, 7 Mar 2000 16:08:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: chas@cmf.nrl.navy.mil, linuxppc-dev@lists.linuxppc.org
Subject: Re: nvram access in 2.3.48?
Message-ID: <20000307160835.H399@opus.bloom.county>
References: <200003072157.QAA95728@borg.cmf.nrl.navy.mil> <200003072211.XAA00471@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200003072211.XAA00471@piglet.grunz.lu>; from mlan@cpu.lu on Tue, Mar 07, 2000 at 11:11:14PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 07, 2000 at 11:11:14PM +0100, Michel Lanners wrote:
> On   7 Mar, this message from Chas Williams echoed through cyberspace:
> >> Another weiredity I've come across in my 2.3 crusade: /dev/nvram
> >> doesn't seem to work anymore.
> >
> > this problem arises from a different source. the nvram driver in
> > drivers/macintosh needs to be converted to use the new driver initalization
> > scheme (like the driver in drivers/char/nvram.c)
> >
> > there were some posts about this about a month or so ago.
>
> Here is the essence:
>
> http://lists.linuxppc.org/listarcs/linuxppc-dev/200002/msg00079.html
>
> And to say I do read every message on this list...

Yeah, that did it (it forgot to change the CONFIG_MAC version).  I'll pass
it along to BK.

I still think it would be a good idea to try and merge the two macintosh nvram
drivers into one tho.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
