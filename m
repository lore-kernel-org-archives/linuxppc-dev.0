Date: Fri, 12 Nov 1999 16:33:47 -0600
From: erik cameron <cameron@senta.uchicago.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: segfault in sndvolmix/libc?
Message-ID: <19991112163347.F6440@senta.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i hope this hasn't been posted already; i didn't see it if it was.  running
R5 (or Q3 or 1999 or whatever the bloody hell...) on a powerbook G3 lombard
333; sndvolmix dies with a segfault regardless of arguments.  here's the 
cut + paste:

muffin:~# gdb sndvolmix
GNU gdb 4.17.0.11 with Linux support
Copyright 1998 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "ppc-unknown-linux"...
(no debugging symbols found)...
(gdb) run
Starting program: /sbin/sndvolmix 

Program received signal SIGSEGV, Segmentation fault.
0x1800738 in _SDA_BASE_ ()
(gdb) info stack
#0  0x1800738 in _SDA_BASE_ ()
#1  0x18006f4 in _SDA_BASE_ ()
#2  0x16df7d4 in __libc_start_main ()
		at ../sysdeps/powerpc/elf/libc-start.c:106

looks to be an issue with libc.  it's the stock libc package that comes with 
R5, glibc-2.1.1-6c.  anyone else seen this?

-- 
erik cameron  unix systems administrator
jfi/mrsec @ the university of chicago
e-cameron@uchicago.edu 
http://senta.uchicago.edu/gnupg for public key

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
