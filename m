From: Frank Murphy <murphyf+linux-ppc@f-m.fm>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Linux kernel / USB keyboard scancode problems
Date: Wed, 27 Aug 2003 09:48:04 +0200
Cc: linuxppc-dev@lists.linuxppc.org
References: <200308231409.24503.murphyf+linux-ppc@f-m.fm> <200308262124.04906.murphyf+linux-ppc@f-m.fm> <20030826200303.GA14385@iram.es>
In-Reply-To: <20030826200303.GA14385@iram.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308270948.04190.murphyf+linux-ppc@f-m.fm>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 26 August 2003 10:03, Gabriel Paubert wrote:
> On Tue, Aug 26, 2003 at 09:24:02PM +0200, Frank Murphy wrote:
> > On Tuesday 26 August 2003 11:35, Gabriel Paubert wrote:
> > > X does its own mapping of raw keycodes to keycodes, and the mapping
> > > is surjective (arghh). The option CustomKeyCodes in X allows you to
> > > bypass this mapping (medium raw modes) but I believe it is deprecated.
>
> On a PC, the Menu key sends e0 5d (and obviously e0 dd for key up). The
> linux keycode is 127 but the X one is 117.

Could you tell me what the keycodes are for Print Screen/SysRq, Scroll Lock,
and Pause are on your keyboard? Just so I can track what F13, F14, & F15
could be.

> The following might be sufficient (just a wild guess, and it will
> certainly break if you don't use linux keycodes):

Thanks for your guessed fix. I'll have to look at what you've done, but, wow,
it's pretty cryptic.

> BTW, I'd also like to keep somewhere the state of the fn key in the
> ADB keyboard driver. I've seen a MacOS utility which allows you to
> use the trackpad as a scroll wheel while the fn button is pressed.
> Thta's what I'd ike to copy.

Huh. That would be pretty cool. Perhaps the real numlock state as well (if
that's even possible).

Frank


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
