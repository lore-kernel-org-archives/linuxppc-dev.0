Date: Thu, 18 Dec 2003 12:10:10 -0500
From: Daniel Jacobowitz <drow@false.org>
To: "Christopher R. Johnson" <cjohnson@gcctech.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: powerpc gdb and gdbserver
Message-ID: <20031218171010.GA16791@nevyn.them.org>
References: <3FE0977B.7020504@gcctech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FE0977B.7020504@gcctech.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 17, 2003 at 12:50:51PM -0500, Christopher R. Johnson wrote:
>
> I'm about to go and grab gdb to build a host-based debugger and
> target-based (PPC 405GP) gdbserver.  Anybody out there with advice on
> how to do this?  Should it just work out of the box or is there stuff I
> need to do to gdbserver for this platform?  The sources I just found are
> gdb-6.0, and I'm using quite recent tools (gcc 3.3.2 glibc 2.3.2
> binutils 2.14.90.0.5 - kudos to Dan Kegle for the crosstools stuff!!!).
>
> Thanks!

It should simply build and work.  You build GDB by setting a --target
and gdbserver by setting a --host.  If you don't want to build a native
GDB at the same time, run the --host build by gdbserver/configure
instead of the top-level src/configure.

--
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
