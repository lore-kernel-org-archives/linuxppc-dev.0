Date: Mon, 19 Jun 2000 23:06:33 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Timothy A. Seufert" <tas@mindspring.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 3D accel on PPC
In-Reply-To: <v04220801b573129ba692@[10.0.0.42]>
Message-ID: <Pine.LNX.4.21.0006192208210.23156-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 18 Jun 2000, Timothy A. Seufert wrote:

>
> Has anybody made progress in getting 3D acceleration to work on PPC?
>
> I *thought* I saw a message a few days ago about XF 4.x DRI work
> being done to make R128 3D accel run on PPC, and I know Kostas
> Gewgriou (hope I spelled that right Kostas ;)

  Close, Georgiou is the correct one actually

> was doing work some
> time ago on 3Dfx Glide.  But I can't seem to find much of anything in
> the mailing list archives.
>

  The dri cvs tree (dri.sourceforge.net) has support for r128 and
xf 4.0.1 will include it as well. About PPC support now i don't
think that it will work out of the box (it might be easy to fix it
though).

I've send some time ago a couple of patches in dri
(not yet included in the tree, but you can get them from
http://sourceforge.net/patch/?group_id=387) that will let
you build the drm modules and XF/DRI. Since i know next to
nothing about ppc asm there are probably errors there, but
my voodoo3 was running fine with them ;P

What is holding back ppc voodoo3 in xfree right now
is PIO support, i tried to use tdfxfb to get away from
this but there a problems there as well (the xserver
needs a 2*vramsize mapping in the framebuffer but fbdev
can't do this unless i patch tdfxfb to think that its
vram is 2*realsize, Geert any ideas how we can get away
from this ?)


> Basically, if anybody out there has accelerated GL running (or close
> to running) on either R128 or Voodoo3 hardware, I'm very interested
> in helping you debug and test it.
>

  If you are willing to live with hardlocks/crashes etc i can send you
what i have for the voodoo3, GL (glide) works but i am missing some
byteswaps in texture transfers(?) in glide so the engince locks badly
and often :(


>    Tim Seufert
>

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
