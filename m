Date: Mon, 2 Oct 2000 23:04:54 +0200
From: Olaf Hering <olh@suse.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + atidriver with rage II/rage pro)
Message-ID: <20001002230454.C15425@suse.de>
References: <20001001224427.A18368@suse.de> <Pine.LNX.4.10.10010021658320.1581-100000@cassiopeia.home> <20001002224703.A15425@suse.de> <39D8F684.B949BA1F@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <39D8F684.B949BA1F@student.ethz.ch>; from daenzerm@student.ethz.ch on Mon, Oct 02, 2000 at 10:56:36PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 02, Michel Dänzer wrote:

> > plum:~ # fbset -depth 24
> > ioctl FBIOPUT_VSCREENINFO: Invalid argument
>
> What about -depth 32? Maybe X uses depth 24, 32 bpp.

Same error.

X can use 8,15,24.  But 32 doesnt work:
(**) ATI(0): Depth 32, (--) framebuffer bpp 32
(EE) ATI(0): Weight given (000) is inconsistent with the depth (32)

Looks like that special chip needs a little extra setup in the kernel
code?


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
