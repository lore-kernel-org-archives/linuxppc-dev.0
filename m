Date: Tue, 28 Mar 2000 19:33:46 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: michdaen@iiic.ethz.ch
cc: "William H. Schultz" <whschult@uncc.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree86 4.0 working as fbdev on Voodoo3
In-Reply-To: <20000328160043.23755.qmail@web110.yahoomail.com>
Message-ID: <Pine.LNX.4.21.0003281913410.29598-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 28 Mar 2000, Michel D?nzer wrote:

>
> --- "William H. Schultz" <whschult@uncc.edu> wrote:
> >
> > I don't know if it's because I moved my existing /usr/X11R6
> > directory before installing, but XFree86 v4 finally works on
> > my Voodoo3.  Granted, it is incredibly slow (slower than
> > v3.3.6), but at least it works--for now.
>
> Doesn't the tdfx driver work?
>

  Beyond endianess problems the tdfx driver uses PIO which isn't
working under ppc right now (and unless the kernel people decide
on a way to export iobase to userland some time soon PIO might
take a while until it gets supported)

>
> > The major problem that I'm having is that the keyboard isn't
> > mapped properly.  The mouse works, so I can logout when I
> > use startx, but I can't log in if I use gdm (or xdm for that
> > matter).  I can't do a ctrl-alt-del to kill the X-Server
> > either, as it isn't recognizing the keys properly.
>
> The Xkb extension doesn't work on PPC yet (a fix by Kostas is on the way :).
>
> Add Option "XkbDisable" to the Keyboard Section.
>

The default xkb rules were missing mac info, you can get the patch from
http://entropy.crashing.org/~howarth/XFree86_v4.0/SOURCES/XFree86-4.0-keysym.patch
which fixes that and also cleans up the macintosh symbols a bit

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
