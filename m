Date: Mon, 7 Dec 1998 09:58:55 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "David A. Gatwood" <marsmail@globegate.utm.edu>
cc: Elgin Lee <ehl@funghi.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux? 
In-Reply-To: <Pine.LNX.3.96.981206190751.2542E-100000@globegate.utm.edu>
Message-ID: <Pine.LNX.4.03.9812070957590.31794-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 6 Dec 1998, David A. Gatwood wrote:
> On Sat, 5 Dec 1998, Elgin Lee wrote:
> > >   2. Adopt XF68_FBdev so it can use the MkLinux video mode ioctl stuff.
> 
> vmode ioctl stuff?  Since when does MkLinux support detecting or changing
> video modes?  This is where we're going to run into trouble either way.

Doesn't the stuff in <asm/vc_ioctl.h> come from MkLinux?

Greetings,

						Geert (who never ran MkLinux)

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
