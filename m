Date: Tue, 15 Dec 1998 22:42:40 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody?
In-Reply-To: <199812131040.LAA03780@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.04.9812152239541.30336-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 13 Dec 1998, Michel Lanners wrote:

> 
> Hi there,
> 
> Anybody successfull in running matroxfb with recent vger kernels?
> 
> I've tried using it alongside controlfb as a second framebuffer, but it
> doesn't initialize. Compiled-in, it only goes through the very first
> debugging message, and then nothing more;  while as a module insmod
> aborts (slightly older matroxfb.c (1.6c)) or hangs the system (most
> recent matroxfb.c (1.8)).
> 
> I've also tried to compile-in matroxfb without controlfb, but that
> failed because offb.c wasn't in (undefined ref to console_getmode et
> al.). I'm right now trying a recompile with OF support compiled in, but
> no framebuffer driver. Let's see....

I'm running matroxfb on a motorola MTX board (PReP machine) which does not
have open firmware. As a module, it crashes in ioremap (don't know why).
the framebuffer X server works. However VGA text mode doesn't work too
well.

--------------------------------------------------------------------------
| Troy Benjegerdes    |    troybenj@iastate.edu    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
