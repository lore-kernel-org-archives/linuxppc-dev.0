Date: Tue, 11 Jul 2000 17:15:42 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
In-Reply-To: <200007080459.XAA32335@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1000711165857.18657B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 07 Jul 2000 17:11:38 +0100, "Iain Sandoe" <iain@sandoe.co.uk> wrote:
>
> Hi again...
>
> Well, it seems that one the list has bounced a message with a title - it
> bounces it agin even if the new version fits within the rules...
>
> Here's what I wanted to send:
>
> hello all,
>
> This may/may not help those who are experiencing X lock-up with sound
> (although I've never had the problem myself).
>
> I have done a backport of Geert's split-up dmasound stuff to 2.2.17pre7.
> Thanks to Geert for helpful suggestions in doing this.
>
I'd like to try the patch, though I didn't see a locked up X either
(probably atyfb64 isn't affected?), but the CPU usage of xmms is also
outrageously high on my Lombard, and there seem to be occasional drop-outs
in the sound (as if the processor can't even always keep up with decoding
the mp3s).
My problem is that my kernel compiled from the rsynced 2.2.17pre10-ben1
sources won't even boot beyond the first stages, to starting up the swapper
- xmon reports

vector: 300 at pc=c00f7854, msr=9032, cp=cp03fb820 [c03fb770]
dar=c8001304, dsisr=42000000
current=c03fa000, pid=1, comm=swapper

without the patch as well as with it. The precompiled 2.2.17pre9-ben1 runs
without significant problems (other than the sound one).

What's more strange, the crashes even seem to affect OF, especially when
I tried to boot with yaboot. Afterwards, I noticed the Mac didn't find
the boot volume and searched for a while til it found my MacOS system
folder. I discovered that all OF boot vars had been set back to defaults,
maybe PRAM had been zapped completely, because also the function keys had been
set back to Brightness/Volume keys etc.
This happened several times after a crash, does anyone know how to avoid
this?

Greetings,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
