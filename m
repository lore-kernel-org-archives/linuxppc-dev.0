Date: Tue, 4 Dec 2001 10:07:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Phil <ibm405.linux@laposte.net>
Cc: Matt Porter <mporter@mvista.com>,
	Simon Winwood <sjw@cse.unsw.edu.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More walnut boottime "fun"
Message-ID: <20011204170715.GJ17651@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011127103042.A11612@cse.unsw.edu.au> <20011126221728.D13091@cpe-24-221-152-185.az.sprintbbd.net> <20011127050754.B15728@cx258813-a.chnd1.az.home.com> <3C0CD3C6.ECB0E61B@laposte.net> <20011204141147.GD17651@cpe-24-221-152-185.az.sprintbbd.net> <3C0CDCB1.9F3A9423@laposte.net> <20011204144532.GF17651@cpe-24-221-152-185.az.sprintbbd.net> <3C0CFDE7.D7950AF6@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C0CFDE7.D7950AF6@laposte.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 04, 2001 at 05:46:31PM +0100, Phil wrote:
> Tom Rini a ?crit :
> >
> > On Tue, Dec 04, 2001 at 03:24:49PM +0100, Phil wrote:
> >
> > > I resync the kernel sources today at 7:15 am GMT.
> > > Any idea ?
> >
> > Have you run a 'make distclean' anytime recently?  If not, try that..
> > (and save your .config someplace).
>
> Yes, i have. I also try to launch it with an empty command line
> as described in a previous e-mail but without success.
> Are the printed adresses by the bootloader correct :
> Thanks.

Everything looks fine, can you look into this more?  And try changing
the -Ttext line in arch/ppc/boot/simple/Makefile from 0x00400000 to
0x00500000

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
