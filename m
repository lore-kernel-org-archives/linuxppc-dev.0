Date: Sun, 21 Dec 2003 22:52:17 -0500
From: Daniel Jacobowitz <drow@false.org>
To: "Christopher R. Johnson" <cjohnson@gcctech.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: powerpc gdb and gdbserver
Message-ID: <20031222035217.GA7378@nevyn.them.org>
References: <3FE0977B.7020504@gcctech.com> <20031218171010.GA16791@nevyn.them.org> <3FE20DAE.6010708@gcctech.com> <20031218203501.GA22392@nevyn.them.org> <3FE2101D.6000005@gcctech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FE2101D.6000005@gcctech.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 18, 2003 at 03:37:49PM -0500, Christopher R. Johnson wrote:
> As I mentioned, the library doesn't exist.  I need to build it, but I'm
> not sure where it comes from (glibc I think) or how to get it built.
> Its a target library, so I have to build it for ppc and deliver it to
> my target box.  That part I know how to do, its creating the library to
> begin with that I don't know how to do.

Wherever you got glibc from you should have gotten libthread_db.so.1
also; maybe it just wasn't installed?

--
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
