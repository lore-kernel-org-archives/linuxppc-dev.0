Message-ID: <39DA138F.EFC230F@relog.ch>
Date: Tue, 03 Oct 2000 19:12:47 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Olaf Hering <olh@suse.de>, "Michel Dänzer" 
	<daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 +
 atidriverwith rage II/rage pro)
References: <Pine.LNX.4.10.10010031817030.15293-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > What about -depth 32? Maybe X uses depth 24, 32 bpp.
> >
> > Same error.
> >
> > X can use 8,15,24.  But 32 doesnt work:
> > (**) ATI(0): Depth 32, (--) framebuffer bpp 32
> > (EE) ATI(0): Weight given (000) is inconsistent with the depth (32)
> >
> > Looks like that special chip needs a little extra setup in the kernel
> > code?
>
> Nope, X doesn't handle 32 bit depth (I've looked at the ati driver for
> hours to no avail). The kernel driver has all necessary code to set up
> the engine for 32 bit depth (rgb weight 8888).

I'll say it again: 32 bpp is depth 24, 32 fbbpp in X 4 terms. No depth 32 yet.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
