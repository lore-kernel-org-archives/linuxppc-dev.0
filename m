Content-Type: text/plain;
  charset="us-ascii"
From: "S. Hebbar" <shebbar@india.tejasnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: relocation error: GLIBC_2.0 not defined 
Date: Fri, 2 Apr 2004 14:32:58 +0530
MIME-Version: 1.0
Message-Id: <200404021432.58644.shebbar@india.tejasnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am getting the following error when I execute any command from the linux
prompt. After rebooting the node, the problem went away.


Error:
=================

> ls -al



ls: relocation error: ls: symbol
, version GLIBC_2.0 not defined in file libc.so.6 with link time reference


> su



bash-2.05# su
bash-2.05# ls
ls: relocation error: ls: symbol
, version GLIBC_2.0 not defined in file libc.so.6 with link time reference
bash-2.05# tail
tail: relocation error: tail: symbol
, version GLIBC_2.0 not defined in file libc.so.6 with link time reference
bash-2.05#
=======================



Target Processor: MPC8260
Target OS: Linux 2.4.20-denx
----------------
LibC: (Included in denx CD).


GNU C Library stable release version 2.2.5, by Roland McGrath et al.
Copyright (C) 1992-2001, 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 2.95.4 20010319 (prerelease/franzo/20011204).
Compiled on a Linux >>2.4.18-26.7.x<< system on 2003-04-08.
Available extensions:
        GNU libio by Per Bothner
        crypt add-on version 2.1 by Michael Glad and others
        linuxthreads-0.9 by Xavier Leroy
        BIND-8.2.3-T5B
        libthread_db work sponsored by Alpha Processor Inc
        NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
        software FPU emulation by Richard Henderson, Jakub Jelinek and others
Report bugs using the `glibcbug' script to <bugs@gnu.org>.
----------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
