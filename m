Date: Wed, 12 Jul 2000 13:27:49 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
In-Reply-To: <200007121112.MAA14217@hyperion.valhalla.net>
Message-ID: <Pine.SOL.3.95.1000712132311.21439E-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jul 2000, Iain Sandoe wrote:

>
> On Wed, Jul 12, 2000, Derek Homeier wrote:
> > On Tue, 11 Jul 2000, Benjamin Herrenschmidt wrote:
> >
> [...]
> >
> > _But_ after some hours of sleep, the machine would not wake up properly.
> > First, the backlight didn't switch on. I tried the usual tricks of playing
> > with the brightness control, but to no effect. The machine was running at
> > first, as I could tell from the usual disk activity caused by slocate.
>
> are you using the sound stuff as modules? If so does the effect manifest
> without sound loaded?  There is code in the sound stuff that talks to the
> PMU...
>
> which PB (if Lombard - I'll see if I can replicate the effect here).
>
Yes, Lombard 333 MHz standard configuration.

I did compile dmasound as module (I noticed that after applyiing your patch,
dmasound was unselected in .config - is there a reason for this?).
I will test this, though I'm not sure if it's easy to reproduce -
if it takes a prolonged time of sleep for the effect to come up...

Thanks,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
