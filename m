Date: Sun, 21 Dec 2003 22:52:57 -0500
From: Daniel Jacobowitz <drow@false.org>
To: Marius Groeger <mgroeger@sysgo.com>
Cc: "Christopher R. Johnson" <cjohnson@gcctech.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: powerpc gdb and gdbserver
Message-ID: <20031222035257.GB7378@nevyn.them.org>
References: <3FE0977B.7020504@gcctech.com> <20031218171010.GA16791@nevyn.them.org> <Pine.LNX.4.56.0312191032280.10154@mag.devdep.sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.56.0312191032280.10154@mag.devdep.sysgo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Dec 19, 2003 at 10:37:23AM +0100, Marius Groeger wrote:
> Also, the official GDB site at http://www.gnu.org/software/gdb tells about
> some known issues with the 6.0 release. One is that the PPC targets had not
> yet implemented "the new frame format". I'm a little bit puzzled about that.
> Does anyone know what this is about?

It's not a big deal.  It's an internal GDB architecture change that
would improve the reliability of backtraces, and other related
features.

--
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
