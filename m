Date: Wed, 17 Mar 1999 11:34:15 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
cc: Jeff Rugen <jrugen@primenet.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Linux Framebuffer List <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [linux-fbdev] Xbh X server/adding acceleration to XF68_FBDev
In-Reply-To: <d3oglscuxs.fsf@valhall.cern.ch>
Message-ID: <Pine.LNX.4.03.9903171133050.8496-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 17 Mar 1999, Jes Sorensen wrote:
> >>>>> "Jeff" == Jeff Rugen <jrugen@primenet.com> writes:
> Jeff> Now, the reason I included the Framebuffer list is I was
> Jeff> interested in adding acceleration for the clgen framebuffer in
> Jeff> the XF68_FBDev server.  What source should I use as a starting
> Jeff> point?  (I have the 3.3.3 server-only source right now).  I'll
> Jeff> also use that as an excuse to verify that 32-bit modes really
> Jeff> work with clgenfb.  Thanks.
> 
> Use the Cirrus Logic accel code from the SVGA server, basically the
> long term goal is to merge the FBDev and SVGA servers.

More or less: the long term goal is to merge XF{68,86}_FBDev with XFree86, the
single server binary in XFree86 4.0. Unfortunately there's quite some
difference between XF86_SVGA 3.3.3.1 and XFree86 3.9x.

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
