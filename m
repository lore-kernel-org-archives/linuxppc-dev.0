Date: Mon, 13 Sep 1999 14:12:30 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Andreas Bogk <andreas@andreas.org>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: New booter
Message-ID: <19990913141229.A30982@them.org>
References: <19990913192403.030901@mailhost.mipsys.com> <m3aeqqoai5.fsf@soma.andreas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3aeqqoai5.fsf@soma.andreas.org>; from Andreas Bogk on Mon, Sep 13, 1999 at 07:51:46PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Sep 13, 1999 at 07:51:46PM +0000, Andreas Bogk wrote:
> 
> Benjamin Herrenschmidt <bh40@calva.net> writes:
> 
> > I forgot to mention that the kernel args can be changed by editing the
> > CMDL resource in the System file with resedit. Don't forget the trailing
> > 0, it's a C string !
> 
> What's the point of a boot application that works without MacOS when
> yu need MacOS to modify the kernel args?


You don't.  You can hack them with a hex editor if you prefer.  Are
there decent tools for dealing with hfs resource forks from linux? Not
that I know of but there is nothing stopping someone from writing one.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
