Date: Wed, 26 May 1999 17:44:43 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Tom Rini <tmrini@ntplx.net>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ioctl 0x7667 in Xpmac
In-Reply-To: <Pine.SUN.4.02.9905260845560.17429-100000@sea.ntplx.net>
Message-ID: <Pine.LNX.4.10.9905261743420.7373-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 May 1999, Tom Rini wrote:
> On Wed, 26 May 1999, Geert Uytterhoeven wrote:
> > Can the people responsible for Xpmac please change the error message
> > 
> > | Fatal server error
> > | ioctl 0x7667 failed: invalid argument.
> > 
> > into
> > 
> > | Fatal server error
> > | ioctl 0x7667 failed: invalid argument (do you have a PowerMac?).
> > 
> > or something like that.
> > 
> > Many people install LinuxPPC on APUS (the second most popular Linux/PPC
> > platform these days), and Xpmac is obviously not meant for non-PowerMacs.
> 
> It's easy enough to do, but doesn't APUS have a framebuffer? (Currently
> if you don't have a readable /dev/fb0, it assumes MkL and uses Xpmac.  A
> more elegant fix would be to check machine type and use that to install
> Xbh on PReP and ??? on APUS)

Hmmm... APUS does have a frame buffer, but it doesn't have the Pmac
compatibility mode. Since lots of people are complaining, it looks like it does
install Xpmac instead of XF68_FBDev on APUS.

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
