Date: Sun, 11 Jul 1999 13:28:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Josh Huber <huberj@WPI.EDU>
cc: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with the atyfb driver on Power Mac G3 (Possible fix)
In-Reply-To: <14214.22225.201034.85545@cpu.wpi.edu>
Message-ID: <Pine.LNX.4.10.9907111326260.392-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 9 Jul 1999, Josh Huber wrote:
> Perhaps this is a question for Geert to answer, but it appears as though 2d acceleration is not being used for scrolling text in xterms. As a demonstration, fire up a new xterm, make it real big, and try and ls -lR /
> 
> Now, it's been so long since I've used xpmac that I don't remember wether or not it performed said operation, but perhaps someone could try it out?

I know.

I haven't done anything on ATI acceleration in XF68_FBDev since December 1998.
I just saw the last alpha of the 3.9 branch of XFree86 finally has support for
ATI Mach64, so it may be a good idea to start working again on it (it time
permits)...

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
