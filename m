Date: Tue, 3 Oct 2000 17:15:40 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
In-Reply-To: <Pine.LNX.4.10.10010031310140.1187-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10010031640040.1330-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Fine, but how would I do that? And how do I tell atyfb to set up two
> > framebuffers for the two separate screens`?
>
> By adding code to atyfb. Sorry for the short answer ;-)

Har har. I almost guessed that. Once I figure out how to initialize the
chip to use separate chunks of RAM for the two ports, the little hack to
make atyfb parse multiple vmode arguments (and consequently set up
and register multiple framebuffers) would indeed be trivial.

Do you have any idea if the config registers dumped to the console by
atyfb are all I need to look at?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
