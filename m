Date: Mon, 21 Jun 1999 16:21:35 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
cc: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Accel. Video on PB G3/300?
In-Reply-To: <376E48D8.B6F2F146@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.9906211620010.30202-100000@michelin.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 21 Jun 1999, Albrecht Dreß wrote:
> 	I managed to install R5 on a PowerBook G3/300, but I could not get accelerated
> video running. I used "video=atyfb:vmode:14,cmode:32,mclk:xx" with xx from 63 to
> 73, but got always the "garbage screen". Has anyone had better results?

Which kernel version is shipped with R5? Does the kernel tell you the estimated
clock crystal frequency (XTAL) during the initialization of the ATI frame
buffer device (atyfb)? If not, they're using a kernel without the clock crystal
frequency estimation patch (present in 2.3.6).

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
