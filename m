Date: Mon, 21 Jun 1999 22:57:44 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Brad Midgley <brad@pht.com>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-users@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: precompiled 2.2.10 kernel available
In-Reply-To: <Pine.LNX.3.95.990621201542.23566A-100000@pacific.pht.com>
Message-ID: <Pine.LNX.4.05.9906212256000.15504-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 21 Jun 1999, Brad Midgley wrote:

> did the protocol of /dev/usbmouse have to change? :( now it appears as a
> ps2 mouse not a busmouse. x can't understand it either way but i'm able to
> use my usb mouse in x by having gpm use it as a ps2 mouse and export it,
> as in

Linus' USB stack differs from Inkays in a few ways.  This is one.  It
seems Busmouse is too limited or something along those lines, so a
modified PS/2 is "better".   The goal eventually is for /dev/mouse to be a
real device, where all mouse data ends up (ala windows and macos w/ multi
mice) and /dev/mouseX for mouseX.  At least thats how it was at one point.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
