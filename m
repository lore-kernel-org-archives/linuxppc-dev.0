From: Frank Murphy <murphyf+linux-ppc@f-m.fm>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Linux kernel / USB keyboard scancode problems
Date: Fri, 29 Aug 2003 17:28:01 +0200
Cc: linuxppc-dev@lists.linuxppc.org
References: <200308231409.24503.murphyf+linux-ppc@f-m.fm> <200308270948.04190.murphyf+linux-ppc@f-m.fm> <20030827182950.GA12646@iram.es>
In-Reply-To: <20030827182950.GA12646@iram.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308291728.01954.murphyf+linux-ppc@f-m.fm>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday 27 August 2003 8:29, Gabriel Paubert wrote:
> Well, except for Scroll Lock, it's a mess. It depends on the other which
> are down at the time the key is pressed.

Thanks for these. Because they're such a mess, perhaps the codes for F13, F14,
and F15 should be used instead. Now just to find out what they are, and if
all Apple keyboards have these keys as F13, 14, & 15.

> > > The following might be sufficient (just a wild guess, and it will
> > > certainly break if you don't use linux keycodes):
> >
> > Thanks for your guessed fix. I'll have to look at what you've done, but,
> > wow, it's pretty cryptic.
>
> Well, it is really simple. Replace 101 by 127 in the ADB to Linux keycode
> mappings. In this way the translation back to "raw" keycodes (only cooked
> twice!) gives 349, which is 256 + 93 (0xe0 0x5d).

Well, I guess the trick is to know which one to change. :)

Frank


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
