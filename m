Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: BDI kernel debug
Date: Tue, 6 Jul 2004 13:31:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200407061331.08613.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

i have some problems with debugging my kernel. This is the first time i use bdi for kernel debugging. ELDK 3.0 is my toolchain (Target 8270).
My bdi2000 can sync with the gdb (ddd) debugger.
I let the kernel run until "start_here", at example. Then i try to step through the source.  I see the source and i can step in it. Sometimes it happens that i spend a lot of time in
linux/kernel/timer.c. Then the output of gdb is "
(gdb) next
 Single stepping until exit from function __cli,
 which has no line number information.

 Program received signal SIGSTOP, Stopped (signal).
 0xc0007dec in __cli ()"

The same output with "step". "Cont" ends also there, although i had set a breakpoint later in the source.

Are there some options in the kernel or in the gdb to set ?

Thanks in advance
Marco



---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
