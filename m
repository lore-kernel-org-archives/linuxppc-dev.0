Date: Wed, 10 Jan 2001 02:09:28 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Linux PPC Developer Mailing List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: status of ppc support in official 2.4.0 or Alan's 2.4.0-ac1
In-Reply-To: <20010109235443.8FE65DBA32@atlas.valhalla.net>
Message-ID: <Pine.SOL.3.95.1010110020032.19163B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 9 Jan 2001, Iain Sandoe wrote:

>
> On Tue, Jan 9, 2001,  Derek Homeier  wrote:
> > On Mon, 8 Jan 2001, Iain Sandoe wrote:
> >> For now, I suggest that (unless you desperately need it), - you disable the
> >> OSS stuff in your .config.
>
> > O.K., did that (I did not have ALSA enabled in the first place), and didn't
> > see the errors again. Nonetheless, xmms is still erring on the Bus
> > (i.e. crashes as soon it is started).
>
> OK.  I'm getting back up to steam - just sorting out the bk stuff :-/
>
> You might trawl the list for xmms comments - I believe that there were
> issues that others resolved.  Which version of xmms?
>
1.0.1

> any way of you telling me where xmms is trashing in the dmaosund driver?
>
Actually it seems to crash before the sound modules are even loaded, so
I'm no longer sure it is dmasound-related, but it definitely only occurs in
2.4.
Still, even without OSS enabled, sound behaves very badly. The speaker tends
to mute in the middle of playing a file, and some apps like wmapm or
wmmon mysteriously crash while sound output is active.

The "modprobe: Can't locate module sound-service-1-0" and
"modprobe: Can't locate module sound-slot-1" messages still appear when
I'm starting gmix.

Cheers,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
