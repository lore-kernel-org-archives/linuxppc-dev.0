Date: Mon, 31 May 1999 09:54:42 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Konstantinos Margaritis <kmargar@cc.uoa.gr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: g200 hw 3d on powerpc
In-Reply-To: <99053103585003.30874@proton>
Message-ID: <Pine.LNX.4.10.9905310951250.29997-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 31 May 1999, Konstantinos Margaritis wrote:
>    If anyone noticed, the g200-dev project is proceeding along very nicely
> (http://lists.openprojects.net/mailman/listinfo/g200-dev), and it's about
> writing a hw OpenGL driver for the Matrox G200 card. Now I don't really
> care about having a video card that will only work on linux (I think it
> does already on powerpc, using matroxfb) and both mac-on-linux and
> shapeshifter could make a mac card unnecessary even.

Nice!

>    I talked to some g200-dev developers and the opinions were divided. In
> particular, one thinks that fbdev+g200-glx will work, another one does not.
>    The point is if a user-mode 3d driver, could access the raw hardware
> thru a fb device. I understand that the framebuffer gets mmap'd but what
> about the registers?

You can map the MMIO registers from userspace. That's what the mmio_start and
mmio_len fields in fb_fix_screeninfo are for. More info about the frame buffer
device subsystem can be found in my paper I presented at Linux Expo '99:

    http://www.cs.kuleuven.ac.be/~geert/Linux/Expo/

>    Anyway, I hope you will see it's an important issue here. If this
> just works on one system, chances are that there will be more willing to
> buy the g200 (and even g400 which is also open-specs).

And once one manufacturer provides specs for their 3D acceleration, others will
follow...

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
