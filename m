Date: Tue, 3 Oct 2000 18:19:27 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Olaf Hering <olh@suse.de>
cc: Michel Dänzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + atidriver
 with rage II/rage pro)
In-Reply-To: <20001002230454.C15425@suse.de>
Message-ID: <Pine.LNX.4.10.10010031817030.15293-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > What about -depth 32? Maybe X uses depth 24, 32 bpp.
>
> Same error.
>
> X can use 8,15,24.  But 32 doesnt work:
> (**) ATI(0): Depth 32, (--) framebuffer bpp 32
> (EE) ATI(0): Weight given (000) is inconsistent with the depth (32)
>
> Looks like that special chip needs a little extra setup in the kernel
> code?

Nope, X doesn't handle 32 bit depth (I've looked at the ati driver for
hours to no avail). The kernel driver has all necessary code to set up
the engine for 32 bit depth (rgb weight 8888).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
