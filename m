Date: Sat, 16 Dec 2000 16:41:20 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: Tony Mantler <nicoya@apia.dhs.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SMP stall on process creation
Message-ID: <20001216164119.A19128@drow.them.org>
References: <20001216160004.A18814@drow.them.org> <v04003a09b6618d780015@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04003a09b6618d780015@[24.70.162.12]>; from nicoya@apia.dhs.org on Sat, Dec 16, 2000 at 03:34:14PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Dec 16, 2000 at 03:34:14PM -0600, Tony Mantler wrote:
> At 3:00 PM -0600 12/16/2000, Daniel Jacobowitz wrote:
> >I've been using a dual G4/500 with the linuxppc_2_5 tree for a couple weeks
> >now, and having all sorts of strange problems.  While trying to debug one
> >(console corruption on select, and sometimes on boot), I discovered
> >something very interesting.
> >
> >I ran, in zsh, this command:
> >% time (for i in {1..100}; do /bin/echo -n; done)
> >
> >on several machines.  On an old 604e/200:
> >  0.52s user 1.25s system 100% cpu 1.759 total

> Just ran this on my 9600/200mp, 2.4.0-test11 (linux-pmac-devel, not
> terribly current). time says:
>  0.84s user 2.63s system 100% cpu 3.466 total

That's kind of upsetting right there :)

If I can figure out how to do profiling I'll try to track this down.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
