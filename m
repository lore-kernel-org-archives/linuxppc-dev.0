Message-ID: <39852D5F.22135576@relog.ch>
Date: Mon, 31 Jul 2000 09:40:15 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Daniel Jacobowitz <drow@false.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
References: <200007301959.UAA25203@hyperion.valhalla.net>
	 <3984708A.D2D39371@student.ethz.ch> <20000730201214.A11467@drow.them.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz wrote:
>
> On Sun, Jul 30, 2000 at 08:14:35PM +0200, Michel D?nzer wrote:
> > Before building, you should have copied xc/config/cf/{xf86site,host}.def
> >
> > Then edit the newly created host.def - you probably only want to build the
> > server and drivers, and choose the drivers you want.
> >
> > For DRI, you may have to edit even more files in config/cf/, AFAIK DRI is only
> > built on i386 by default.
>
> DRI won't build on powerpc at present.  The first place it dies is in
> the makefiles for libOSmesa, where $(SUBDIRS) becomes empty.

Which tree and version?

I was playing around with stock X 4.0.1 on the train about an hour ago, and
apart from the /dev entries missing (anyone has the majors/minors handy? :),
everything _seemed_ to at least load fine...

I'll report the definite result after more testing.


Michel


--
I don't suffer from stress. I'm a carrier.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
