From: shuaiye1999@sohu.com
Message-ID: <4364838.1058410538128.JavaMail.postfix@mx49.mail.sohu.com>
Date: Thu, 17 Jul 2003 10:55:38 +0800 (CST)
To: "Brian S. Park" <brian@corelis.com>
Subject: Re:ppc_4xx-gdb and gdbserver
Cc: "hi" <linuxppc-embedded@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-----  Original Message  -----
From: Brian S. Park
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc_4xx-gdb and gdbserver
Sent: Wed Jul 16 02:05:11 CST 2003

>
> Hi All,
> I need help again.
>
> I'm trying to set up a remote debugging so I can use DDD to debug my program.
> I did "gdbserver yakatori:2001" on the target (yakatori is the name of the
> target) and on the host, I ran ppc_4xx-gdb and ran "target remote
> yakatori:2001"
> It seems to connect ok but when I try to load the code, I get error message
> and I can not debug the program.
>
> I'm using ELDK 2.1.0 for ppc_4xx and have no problem running GDB locally on
> the target.
>
> Any help will be appreciated.
> Thank you.
>
> Brian
>
> Output from the target:
> bash-2.05# gdbserver yakatori:2001
> Ready to attach to a process
> Remote debugging from host 192.168.1.78

gdb manual will help.
It seems that you'd better load the "test" in gdbserver side,like this:
target>gdbserver yakatori:2001 test
and load the symble file on the gdb side,like this:
gdb)add-symble-file test

best regards,

shuaiye


>
> Output from the host:
> [root@karla2 Library]# ppc_4xx-gdb
> GNU gdb 5.1.1
> Copyright 2002 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "--host=i386-redhat-linux --target=ppc-linux".
> (gdb) target remote yakatori:2001
> Remote debugging using yakatori:2001
> (gdb) load test
> Loading section .interp, size 0xd lma 0x10000114
> Loading section .note.ABI-tag, size 0x20 lma 0x10000130
> Loading section .hash, size 0xd0 lma 0x10000150
> Loading section .dynsym, size 0x210 lma 0x10000220
> Loading section .dynstr, size 0x1a1 lma 0x10000430
> Loading section .gnu.version, size 0x42 lma 0x100005d2
> Loading section .gnu.version_r, size 0x20 lma 0x10000614
> Loading section .rela.dyn, size 0x18 lma 0x10000634
> Loading section .rela.plt, size 0xe4 lma 0x1000064c
> Loading section .init, size 0x28 lma 0x10000730
> Loading section .text, size 0x1180c lma 0x10000758
> Loading section .fini, size 0x20 lma 0x10011f64
> Loading section .rodata, size 0x3e0 lma 0x10011f90
> Loading section .data, size 0xb30 lma 0x10022370
> Loading section .eh_frame, size 0xff0 lma 0x10022ea0
> Loading section .got2, size 0x20 lma 0x10023e90
> Loading section .dynamic, size 0xd8 lma 0x10023eb0
> Loading section .ctors, size 0x8 lma 0x10023f88
> Loading section .dtors, size 0x8 lma 0x10023f90
> Loading section .got, size 0x14 lma 0x10023f98
> Loading section .sdata, size 0x144 lma 0x10023fac
> Start address 0x10000758, load size 81856
> Remote failure reply: ENN
>
>
>
>
> ===============================================================
> Brian S. Park  brian@corelis.com  (562) 926-6727 x143
> ---------------------------------------------------------------
> Everything we do helps our customers get to market
> FASTER with HIGHER quality and LOWER cost
> ===============================================================
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
