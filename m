Date: Sun, 11 Jul 1999 13:18:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Joe Julicher <joe_julicher@macktrucks.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Video questions
In-Reply-To: <3.0.5.32.19990706130838.00867870@mailhost.bulldog.com>
Message-ID: <Pine.LNX.4.10.9907111315330.392-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Jul 1999, Joe Julicher wrote:
> Now that things are working, how do I change the kernel to support
> 1600x1200 for the framebuffer.  I want the full Rage 2+ support.  So using
> the MacOS to "Cheat" doesn't count.  vmode only allows up to mode 20 which
> is 1280x1024 (if memory serves)  
> I have a theory on how to change it.  If I use MacOS to "Cheat" and boot
> with no video driver selected and then use nvmode to inspect the PRAM
> setting I get the mode to be 105.  If I modify macmodes.h to include 105
> and push the end of the list marker (currently at 99) out past 105 would
> that work?

You can use fbset to program any arbitrary resolution, assumed your board
supports it (my RAGE II+ can do 1600x1200, but my monitor is only a 17" with
max. 92 kHz hsync).

> Second question:
> I want to start on a frame buffer driver for the RPC board.  I have the
> board, it is setup.  Where is a good template for a frame buffer driver?
> Does such a thing exist?  Should I learn all I can from the existing FB
> drivers, and then write a template?  The 823 video controller is VERY
> simple so it should not be much more work than what would be in example code.

drivers/video/tgafb.c is a good start for a simple driver that supports one
video mode only. Later you can add support for multiple modes. Check out the
slides of my talk at Linux Expo:

    http://www.cs.kuleuven.ac.be/~geert/Linux/Expo/

There exist other URLs, but I don't have them at hand here. If you have
questions, feel free to ask. You may want to join
linux-fbdev@vuser.vu.union.edu (controlled by majordomo).

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
