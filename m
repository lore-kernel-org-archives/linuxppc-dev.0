Date: Wed, 17 Mar 1999 09:43:51 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Jeff Rugen <jrugen@primenet.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Linux Framebuffer List <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [linux-fbdev] Xbh X server/adding acceleration to XF68_FBDev
In-Reply-To: <Pine.BSI.3.96.990316204520.10665A-100000@usr01.primenet.com>
Message-ID: <Pine.LNX.4.03.9903170942550.8496-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Mar 1999, Jeff Rugen wrote:
> Well, I've done some more work on the Xbh X server for 16- and 32-bit
> support.  I've added some acceleration to the 16- and 32-bit modes, so they
> no longer flicker like they did (basically just got the 8-bit stuff
> working with the different modes).  32-bit mode seems to work for me (using
> fvwm2 and a few applications), but 16-bit mode needs some work.  It's
> started though.
> 
> This time I put the source with the executable.  Its all at:
> ftp://linuxppc.cs.nmt.edu/pub/linuxppc/patches/Xbh-16bit-glibc2x
> 
> Now, the reason I included the Framebuffer list is I was interested in
> adding acceleration for the clgen framebuffer in the XF68_FBDev server.
> What source should I use as a starting point?  (I have the 3.3.3 server-only
> source right now).  I'll also use that as an excuse to verify that 32-bit
> modes really work with clgenfb.  Thanks.

The patches for Mach64 acceleration in XF68_FBDev are at

    http://www.cs.kuleuven.ac.be/~geert/bin/xc-3.3.3-geert-19981210.diff.gz

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
