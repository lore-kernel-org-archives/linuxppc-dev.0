Message-ID: <3B386E15.455B2C74@dgt-lab.com.pl>
Date: Tue, 26 Jun 2001 13:12:21 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: What's wrong with my kernel debugging?
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to debug kernel module on remote PPC machine.
Say me if I'm doing something wrong.

I had fonud 0xc303b04c address using loadmodule.sh script


==========================================================================

Copyright 2000 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you

are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for
details.
This GDB was configured as "ppc-redhat-linux".
(gdb) target remote /dev/ttyS0
Remote debugging using /dev/ttyS0
0xc000aff8 in ?? ()
(gdb) add-symbol-file /lib/modules/vtxcsmod 0xc303b04c
add symbol table from file "/lib/modules/vtxcsmod" at
        .text_addr = 0xc303b04c
(y or n) y
Reading symbols from /lib/modules/vtxcsmod...done.
(gdb) b init_module
Breakpoint 1 at 0xc30aba20: file vtxcs_mod.c, line 93.
(gdb) continue
Continuing.
warning: Cannot insert breakpoint 1:
Cannot access memory at address 0xc30aba20
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ why ???




--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
