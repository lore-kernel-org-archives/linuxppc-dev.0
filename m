Date: Tue, 1 Aug 2000 14:03:59 -0700
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
Message-ID: <20000801140359.A24586@drow.them.org>
References: <200007301959.UAA25203@hyperion.valhalla.net> <3984708A.D2D39371@student.ethz.ch> <20000730201214.A11467@drow.them.org> <39852D5F.22135576@relog.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <39852D5F.22135576@relog.ch>; from daenzer@relog.ch on Mon, Jul 31, 2000 at 09:40:15AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 31, 2000 at 09:40:15AM +0200, Michel Dänzer wrote:
> Daniel Jacobowitz wrote:
> >
> > On Sun, Jul 30, 2000 at 08:14:35PM +0200, Michel D?nzer wrote:
> > > Before building, you should have copied xc/config/cf/{xf86site,host}.def
> > >
> > > Then edit the newly created host.def - you probably only want to build the
> > > server and drivers, and choose the drivers you want.
> > >
> > > For DRI, you may have to edit even more files in config/cf/, AFAIK DRI is only
> > > built on i386 by default.
> >
> > DRI won't build on powerpc at present.  The first place it dies is in
> > the makefiles for libOSmesa, where $(SUBDIRS) becomes empty.
>
> Which tree and version?
>
> I was playing around with stock X 4.0.1 on the train about an hour ago, and
> apart from the /dev entries missing (anyone has the majors/minors handy? :),
> everything _seemed_ to at least load fine...
>
> I'll report the definite result after more testing.

Straight 4.0.1.  I turned on BuildXF86DRI in linux.cf in an attempt to
build libOSmesa, and failed.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
