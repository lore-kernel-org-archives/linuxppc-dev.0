In-Reply-To: <p04310105b507c981404f@[192.168.240.10]>
Date: Wed, 29 Mar 2000 18:53:17 +0200
To: Alain RICHARD <alain.richard@equation.fr>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: new XFree86 4.0 rpms
Message-Id: <20000329185317.001339@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 29, 2000, Alain RICHARD <alain.richard@equation.fr> wrote:


>I have tried several version of your packages and was unable to get
>it working on my iBook.
>
>I have made a configuration that seems to be working (the screen,
>resolution and fbdev driver is loading without any error), but the
>screen is erased and remains black.
>
>The only X server working so far is the Xpmac one.
>
>Also I would like to test the ati module that is supposed to
>recognized the ATI Rage Mobility, but you haven't build it.
>
>You'll find here the XFree86 output :

This won't work, at least not until I (or someone else) fix atyfb for the
Rage Mobility & LVDS LCD connection. The problem is that you are running
offb, not atyfb, and I don't think the current XF4 copes very well with it.
If you want to use XFree mach64 driver for the mobility (instead of the
fbdev driver), you'll crash because X will try to do PIO to the VGA
registers of the mobility and this won't work on any new machine.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
