Message-Id: <200008301941.UAA13718@hyperion.valhalla.net>
Date: Wed, 30 Aug 2000 20:42:02 +0100
Subject: Re: [PATCH] via-cuda (CUDA_COMBINED_FORMAT_IIC)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>, mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 30, 2000, Geert Uytterhoeven
> The generic i2c subsystem works (at least `used to work') on PPC as well. I
> once wrote an i2c `driver' (something that can read from and write to 2 signal
> lines, very very complex :-)

Well, today I wish I could get at SDA/SCL - because I think I would have a
working solution to my need (to read the TDA7433).

Maybe it's complex - or at least tedious - because of working within the OS
- but it is also specified by the i2c spec - so a solvable problem.

All the time on this patch has been spent second-guessing what the CUDA does
with its command packets... and at the end I still can't read the chip (lots
of info from the SPDs & other devices ;-)

CUDA is also on m68k? (I see some conditionals in the 2.4.0 stuff for
CONFIG_MAC)

I really would be very grateful if anyone has any more sources of info on
the command packets contents for it (CUDA)...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
