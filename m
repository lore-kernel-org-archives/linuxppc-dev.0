Date: Tue, 22 Jun 1999 15:49:18 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
cc: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Accel. Video on PB G3/300?
In-Reply-To: <376F9308.EC651910@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.9906221547350.5853-100000@michelin.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 22 Jun 1999, Albrecht Dreß wrote:
> Geert Uytterhoeven wrote:
> [snip]
> > Hence you need the clock crystal frequency estimation patch to be able to use
> > atyfb and acceleration.
> > 
> > Copying drivers/video/atyfb.c from 2.3.6 should do the trick.
> Installed it, and now...
> 
> MacOS display is /pci/ATY,RageLTPro
> atyfb: 3D RAGE LT PRO [0x4c50 rev 0xdc] 4M SGRAM, 29.498928 MHz XTAL, 230 MHz
> PLL, 100 Mhz MCLK
> 
> I could not (yet) get X configured, but the system console comes up with the
> atyfb video driver.  (BTW, should I add "mclk:100" to its arguments?).

That's not needed: atyfb uses a 100 MHz memory clock by default for the 3D RAGE
LT PRO, as it reports.

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
