Date: Mon, 7 Dec 1998 11:28:47 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux?
In-Reply-To: <19981207014016F.roikawa@rr.iij4u.or.jp>
Message-ID: <Pine.LNX.4.03.9812062113110.26833-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Dec 1998, Ryuichi Oikawa wrote:
> From: anthony tong <atong@uiuc.edu>
> Subject: Re: XF68_FBDev under MkLinux?
> > 
> > Geert Uytterhoeven (Sat, Dec 05, 1998 at 11:20:33PM +0100):
> > >   2. Adopt XF68_FBdev so it can use the MkLinux video mode ioctl stuff. This
> > >      requires no kernel changes. In XF68_FBDev, the video ioctl and mmap stuff
> > >      has to be changed slightly.
> > > 
> > > I think the second solution is the least amount of work.
> > 
> > Agreed.
> 
> Simple question: What is the advantage of fbdev server without
>  frame buffer device ?

This is indeed a very good question!

I think the most important reason is that you're integrated with XFree86 (like
all the other Linux ports), and get all its extra features for free.

Another approach would be to create a new subdirectory
xc/programs/Xserver/hw/xfree68/xpmac/, that only differs from the xfree68/fbdev
directory by the differences between the frame buffer device API and the
MkLinux graphics API. The disadvantage of this is that you still have two
server binaries, though.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
