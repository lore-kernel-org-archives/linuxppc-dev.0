Message-ID: <38EB79F9.6EED0003@astro.wisc.edu>
Date: Wed, 05 Apr 2000 12:38:02 -0500
From: Matt Haffner <haffner@astro.wisc.edu>
Reply-To: haffner@astro.wisc.edu
MIME-Version: 1.0
To: Arnaud Gomes-do-Vale <arnaud@carrosse.frmug.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4 & sound problems
References: <m3u2hgy78f.fsf@melchior.fleming.u-psud.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Arnaud Gomes-do-Vale wrote:
>
> Matt Haffner <haffner@astro.wisc.edu> wrote :
> > I'm a little confused why there is a problem with XFree 4 and sound
> > since I wouldn't think XFree does anything with it, but I'm getting hard
> > freezes when playing MP3's in XMMS and mpg123 whenever I do significant
> > X actions (switching desktops, starting Netscape, mousing a menu, etc.).
> > If I just let things go and don't touch anything, it plays fine. The
> > freeze requires a reset button reboot--the machine is not reachable at
> > all (i.e. it's not just X).
>
> Are you shure this is an X11 or kernel related problem ?
> For me it sounds like you are using ESD evironment (for
> example gnome and/or Enlightment WM). The Enlighment
> Sound Daemon in some cases can't access /dev/sound while
> something else use it (eg: xmms with OSS output or mpg123)
> so X events associated with sounds in E or Gnome waits until
> the sound can be played.

I know exactly what you are talking about, since I used to get this when
we had to run xmms with the OSS module in 1999, but I've been using ESD
since 2K was released. But this is much more severe than those hiccups.
I don't have Gnome sounds on (and ditched E a while ago). I can make it
happen as easy as start a song playing in xmms and then launch netscape
(even from the command line). As soon as the first window starts to
render, freeze...

Thanks for the reply though.

mh
--
Matt Haffner                      /|------|\    University of Wisconsin
Dept. of Astronomy               /|--------|\            Madison
haffner@astro.wisc.edu          /|----------|\
           WHAM project -- http://www.astro.wisc.edu/wham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
