Date: Sat, 17 Jan 2004 19:21:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
	linas@austin.ibm.com, valvoline <valvoline@vrlteam.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Broadcom BCM94306
In-Reply-To: <20040116195406.GA25566@iram.es>
Message-ID: <Pine.GSO.4.58.0401171920040.1950@waterleaf.sonytel.be>
References: <20040114161107.GM2658@adapter.n0skillz.org>
 <20040114181350.B40506@forte.austin.ibm.com> <70D6BF86-473D-11D8-A8C3-000A95A4DC02@kernel.crashing.org>
 <20040115115023.GA12001@iram.es> <C404D01A-475A-11D8-A8C3-000A95A4DC02@kernel.crashing.org>
 <20040116195406.GA25566@iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 16 Jan 2004, Gabriel Paubert wrote:
> On Thu, Jan 15, 2004 at 02:00:16PM +0100, Segher Boessenkool wrote:
> > >P.S.: there is nothing wrong with calling little-endian wrong or
> > >perverted or fucked-up ;-)
> >
> > I don't know if I trust you here -- you wrote "bug endian" just a few
> > lines up ;-)
>
> Damned laptop keyboards! U and I keys are just too close from each
> other;-) Apart from this, if you look up some archives, you'll certainly
> find that I think, live and breathe big-endianly ;-) (bit 0 is the most
> significant bit, period)

Although I prefer big endian myself, I don't like counting bits in the `wrong'
direction ;-) Hence bit 0 is always the least significant bit.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
