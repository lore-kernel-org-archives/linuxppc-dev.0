Date: Tue, 25 May 1999 11:49:59 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Wolfgang Denk <wd@denx.de>
cc: linuxppc-dev@lists.linuxppc.org, dev@kernel.crashing.org
Subject: Re: LinuxPPC-DR-1.0: X11 config for Powerbook G3 series?
In-Reply-To: <199905162253.AAA00308@denx.muc.de>
Message-ID: <Pine.LNX.4.10.9905251149190.32176-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 17 May 1999, Wolfgang Denk wrote:
> 
> I cannot get X11 running on  my  G3  series;  I'm  using  `fbset'  as
> documented, and get:
> 
> Mode "name"
>     # D: 100.000 MHz, H: 93.985 kHz, V: 116.318 Hz
>     DotClock 100.001 
>     HTimings 1024 1040 1048 1064
>     VTimings 768 784 792 808 
>     Flags    "-HSync" "-VSync"
> EndMode 
> 
> 
> However, the Xserver complains
> 
> 	...
> 	(--) FBDev: Mode "1024x768" needs hsync freq of 93.99 kHz. Deleted.
> 	(**) FontPath set to "unix/:-1"
> 	(**) FBDev: Using XF86Config video mode database
> 
> 	Fatal server error:
> 	No valid modes found.
> 
> What am I missing?   [Full logs attached below.]
> 
> Wolfgang
> 
> -- 
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> "How is this place run - is it an anarchy?"
> "No, I wouldn't say so; it is not that well organised..."
> 
> ...
> [root@luke X11]# fbset -xres 1024 -yres 768 -depth 16
> [root@luke X11]# fbset -x

Either use

    startx -- -bpp 16

or add

    DefaultColorDepth 16

to `Section "Screen"' of XF86Config.

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
