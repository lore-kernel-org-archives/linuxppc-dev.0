Date: Fri, 16 Jun 2000 12:08:18 -0400
From: Josh Huber <huber@mclx.com>
To: Stefan Berndtsson <stefan@nocrew.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: debugging problems
Message-ID: <20000616120818.A16747@mclx.com>
References: <878zwaatqb.fsf@hades.nocrew.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878zwaatqb.fsf@hades.nocrew.org>; from stefan@nocrew.org on Tue, Jun 13, 2000 at 10:08:28AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 13, 2000 at 10:08:28AM +0200, Stefan Berndtsson wrote:
>
> How do I get a debugger to work with 2.3.99/2.4.0 kernels?
>
> I can't get gdb to run anything.
>
> $ gdb ./a.out
> GNU gdb 4.18
> Copyright 1998 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "powerpc-unknown-linux-gnu"...
> (gdb) run
> Starting program: /home/stefan/mud/cdp/./a.out
> Cannot insert breakpoint -1:
> Cannot access memory at address 0xffffbc57.
> (gdb)
>
> that's all I get.
>
> Has something changed with PTRACE in 2.3.99/2.4?

from ac@lkml:
> I was able to get ac15 to boot and run fine for about 18hrs crunching rc5 keys on a
> DS20.  Then I tried to update to ac17 and it won't compile any more. I get the
> following error with ac17:

All the non x86 platforms got broken by the ptrace change. This fixes an ugly
kernel race and needs asm level changes for the other platforms. Painful
but important to do.

Alan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
