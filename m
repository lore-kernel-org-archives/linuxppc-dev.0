Date: Sun, 30 Jul 2000 20:12:14 -0700
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
Message-ID: <20000730201214.A11467@drow.them.org>
References: <200007301959.UAA25203@hyperion.valhalla.net> <3984708A.D2D39371@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3984708A.D2D39371@student.ethz.ch>; from daenzerm@student.ethz.ch on Sun, Jul 30, 2000 at 08:14:35PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 30, 2000 at 08:14:35PM +0200, Michel D?nzer wrote:
> Before building, you should have copied xc/config/cf/{xf86site,host}.def
>
> Then edit the newly created host.def - you probably only want to build the
> server and drivers, and choose the drivers you want.
>
> For DRI, you may have to edit even more files in config/cf/, AFAIK DRI is only
> built on i386 by default.

DRI won't build on powerpc at present.  The first place it dies is in
the makefiles for libOSmesa, where $(SUBDIRS) becomes empty.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
