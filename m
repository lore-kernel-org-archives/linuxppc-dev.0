Date: Mon, 3 May 1999 11:52:32 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Mike Ladwig <mike@twinpeaks.prc.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: atyfb and 8500+ATI RagePro
In-Reply-To: <372B4B1A.1B496127@twinpeaks.prc.com>
Message-ID: <Pine.LNX.4.10.9905031145560.3092-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Mike,

> I've been having major problems using the atyfb driver with my 8500, and
> finally have a clue or two to report.
> 
> If I try booting the 2.2.6 kernel from the new beta R5 with an unchecked
> "No video driver" and "video=atyfb:vmode:19,cmode:16", I get a frozen
> machine and a colored static rectangle on my display.  If I use the same
> command line, but specify a lower mclk value (most all lower ones work),
> the system will boot, but I will get the same types of colored static rectangles.
> 
> Recently, I came across a post my Hugy Caley about a "hacked" atyfb
> driver from Abe White.  I thought I'd give it a try.  Using the
> parameter line, "video=atyfb:vmode:19,cmode:16", I actually get a
> somewhat reasonable display, although the text of the console lines are
> repeated several times on each  line; every ~25 characters, the line
> starts over.  Also, the kernel Hugh sent me didn't boot all the way, not

Usually such repeats are caused by incorrect DSP values for the display FIFO.

> finding my boot device - probably unrelated to the video issue. The
> atyfb driver prints out (a close reconstruction from the garbled video):
> 
> /bandit, ATY,XCLAIMVRPro atyfb: 3D RagePro(BGA, PCI) 0x479 rev 0x7c 12M
> SGRAM 230 MhzPLL, 100 Mhz MCLK
> 
> Anyway, I'm not sure where to go from here.  I'm a programmer and
> willing to jump in, but not knowledgable about device driver debugging.
> 
> Any help or advice would be greatly appreciated!

Sorry, no more clues :-(

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
