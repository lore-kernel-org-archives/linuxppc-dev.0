Date: Fri, 19 Dec 2003 10:37:23 +0100 (CET)
From: Marius Groeger <mgroeger@sysgo.com>
To: Daniel Jacobowitz <drow@false.org>
Cc: "Christopher R. Johnson" <cjohnson@gcctech.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: powerpc gdb and gdbserver
In-Reply-To: <20031218171010.GA16791@nevyn.them.org>
Message-ID: <Pine.LNX.4.56.0312191032280.10154@mag.devdep.sysgo.com>
References: <3FE0977B.7020504@gcctech.com> <20031218171010.GA16791@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 Dec 2003, Daniel Jacobowitz wrote:

> On Wed, Dec 17, 2003 at 12:50:51PM -0500, Christopher R. Johnson wrote:
> >
> > I'm about to go and grab gdb to build a host-based debugger and
> > target-based (PPC 405GP) gdbserver.  Anybody out there with advice on
> > how to do this?  Should it just work out of the box or is there stuff I
> > need to do to gdbserver for this platform?  The sources I just found are
> > gdb-6.0, and I'm using quite recent tools (gcc 3.3.2 glibc 2.3.2
> > binutils 2.14.90.0.5 - kudos to Dan Kegle for the crosstools stuff!!!).
> >
> > Thanks!
>
> It should simply build and work.  You build GDB by setting a --target
> and gdbserver by setting a --host.  If you don't want to build a native
> GDB at the same time, run the --host build by gdbserver/configure
> instead of the top-level src/configure.

Yes, I can confirm that. I just tried single and multi threaded debugging
with gdb 6.0 release on a PPC405 target. I used a cross gdb with gdbserver
and a native gdb. Only the native gdb (ie. the one running on the target)
had problems with threads. Any idea about that?

Also, the official GDB site at http://www.gnu.org/software/gdb tells about
some known issues with the 6.0 release. One is that the PPC targets had not
yet implemented "the new frame format". I'm a little bit puzzled about that.
Does anyone know what this is about?

I'm using gcc 2.95.3 and glibc 2.2.5 at the moment.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>
Project Manager

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Am Pfaffenstein 14
55270 Klein-Winternheim, Germany

Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
www.sysgo.com | www.elinos.com | www.osek.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
