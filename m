Date: Wed, 3 Dec 2003 12:14:10 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Christopher R. Johnson" <cjohnson@gcctech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: quick survey only for PowerPC 405 folks
Message-ID: <20031203201410.GB30768@gate.ebshome.net>
References: <3FCE04E3.9080602@gcctech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FCE04E3.9080602@gcctech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 03, 2003 at 10:44:35AM -0500, Christopher R. Johnson wrote:
>
> I'm trying to stabilize some tools and OS components, and would like
> your recommendations - you can reply directly to me if you like.
> Thanks!  Currently my target processors are 200mHz 405GP and 333mHz
> 405GPr on a custom-designed board.  We are already running 2.4.23-rc1 on
> the board with our own bootstrap.
>
> 1. Kernel version:

2.4.21

> 2. Kernel obtained from:

linuxppc-2.4 BK tree + some custom stuff

> 3. gcc version:

2.95.3

> 4. glibc version:

2.2.3

> 5. binutils version:

2.10.91

> 6. Did you build your own toolchain?

No

> 7. If not, where did it come from?

MVL 2.1

> 8. What is your development environment (editors, tools, debuggers, etc.)?

p4, gdb, ddd, Abatron, RiscWatch, brain :)

> 9. I have an Abatron, any useful magic I should know?

Usual stuff for any hw debugger. Nothing Abatron specific

> 10. How do you manage building, configuring and delivering user-mode
> software for the target?
>

Build: rather complex make + some Perl scripts

Delivery:
  a) production: rpm + custom update daemon
  b) development: NFS mount, or rsync, or scp, or whatever particular
developer prefers.


Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
