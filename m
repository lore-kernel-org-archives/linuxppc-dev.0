Date: Wed, 12 Jul 2000 14:36:34 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
In-Reply-To: <200007121137.MAA18130@hyperion.valhalla.net>
Message-ID: <Pine.SOL.3.95.1000712142647.21439G-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jul 2000, Iain Sandoe wrote:
>
> > I did compile dmasound as module (I noticed that after applyiing your patch,
> > dmasound was unselected in .config - is there a reason for this?).
>
> Yes, the CONFIG_DMASOUND changed to a set of CONFIG_DMASOUND_XXXX for the
> various different platforms.  Note there is no such thing as 'dmasound.o'
> any more :-)
>
> you have to modprobe:
> soundcore
> dmasound_core <params>
> dmasound_awacs
>
Ay, that may be the rub! I think I've still seen 'dmasound.o' when I did
a lsmod. I did not change conf.modules, that's for sure.
I have no idea, though, where I might have got the old dmasound.o from,
because I made a 'mrproper' before the last compiles. I can imagine that
would have messed up everything a bit, though I'm wondering how the
module got loaded with the wrong kernel version at all...
I noted some failed module dependencies, but none with the sound stuff
AFAIKT. I'll sort this out when I'm back at my machine.

Thanks,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
