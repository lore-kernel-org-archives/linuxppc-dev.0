Message-ID: <38DA840D.D6BE805E@iiic.ethz.ch>
Date: Thu, 23 Mar 2000 21:52:29 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "William H. Schultz" <whschult@uncc.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree86 4.0 Generic VGA
References: <200003210600.AAA05535@lists.linuxppc.org>
	            <38D9AEEC.7ACB82D1@uncc.edu> <38D9D30C.478C4E55@iiic.ethz.ch> <38DA24A5.D3FC9BA9@uncc.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"William H. Schultz" wrote:

> > Have you tried the tdfx driver? IIRC Kostas has it working.
> >
> Forgive me for being slow, but where can I get it?  I was
> under the impression that the tdfx driver, unlike most of
> the others, was compiled straight into the kernel.  I know
> I haven't gotten that to work.

No, it's part of the XFree86 4.0 sources. Do you mean the DRM kernel module
(for DRI hardware accelerated 3D) for it? You don't need that for 2D, but if
you'd like it to work, contact Kostas.


> XFree86 -configure definately doesn't work.  I know I should
> be paying more attention to the errors, but I get fewer by
> running xf86configure instead of the other way.

What does it do?


Michel


--
Software is like sex; it's better when it's free
 -- Linus Torvalds
______________________________________________________________________________
Michel Dänzer                             ///           mdaenzer@earthling.net
                                     __  /// 	     AmigaOS/Linux(Debian/PPC)
Student of computer science at the   \\\///   Team *AMIGA*      ICQ #: 5675698
Swiss Federal Institute of Technology \\\/   AUGS member #163      IRC: CoOpER

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
