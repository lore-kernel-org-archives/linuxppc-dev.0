Date: Mon, 7 Dec 1998 21:06:24 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Elgin Lee <ehl@funghi.com>
cc: "David A. Gatwood" <marsmail@globegate.utm.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux? 
In-Reply-To: <199812071822.KAA02538@porcini.funghi.com>
Message-ID: <Pine.LNX.4.03.9812072105450.10596-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Dec 1998, Elgin Lee wrote:
> Perhaps I misunderstand.  What ioctls are you proposing to use?
> MkLinux (Linux and Mach sides combined) supports ioctls like
> VC_GETMODE, VC_SETMODE, VC_INQMODE, VC_SETCMAP, and VC_GETCMAP.

These ioctls.

> However, I believe that the Mach drivers will currently only allow you
> to use the one video mode (width, height, depth, etc.) in effect from
> the MacOS side.  That one mode should be revealed by the video ioctls.
> 
> Would that restriction cause a problem?

No problem. That's very similar to `mode "default"' with XF68_FBDev.

> >>>>> In <Pine.LNX.3.96.981207114602.20658A-100000@globegate.utm.edu> 
> >>>>>	"David A. Gatwood" <marsmail@globegate.utm.edu> wrote:
> 
> > On Mon, 7 Dec 1998, Geert Uytterhoeven wrote:
> > 
> > > On Sun, 6 Dec 1998, David A. Gatwood wrote:
> > > > On Sat, 5 Dec 1998, Elgin Lee wrote:
> > > > > >   2. Adopt XF68_FBdev so it can use the MkLinux video mode ioctl stuff.
> > > > 
> > > > vmode ioctl stuff?  Since when does MkLinux support detecting or changing
> > > > video modes?  This is where we're going to run into trouble either way.
> > > 
> > > Doesn't the stuff in <asm/vc_ioctl.h> come from MkLinux?
> > 
> > Maybe.  I'm not saying the linux server part doesn't have the support,
> > just that the mach kernel drivers don't, AFAIK.  :-)
> 

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
