To: linuxppc-dev@lists.linuxppc.org
Subject: debugging problems
Content-Type: text/plain; charset=US-ASCII
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 13 Jun 2000 10:08:28 +0200
Message-ID: <878zwaatqb.fsf@hades.nocrew.org>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


How do I get a debugger to work with 2.3.99/2.4.0 kernels?

I can't get gdb to run anything.

$ gdb ./a.out
GNU gdb 4.18
Copyright 1998 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "powerpc-unknown-linux-gnu"...
(gdb) run
Starting program: /home/stefan/mud/cdp/./a.out
Cannot insert breakpoint -1:
Cannot access memory at address 0xffffbc57.
(gdb)

that's all I get.

Has something changed with PTRACE in 2.3.99/2.4?

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
