Date: Mon, 26 Jul 2004 22:38:32 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Can't compile 2.6.7 with gcc 3.4.1
Message-Id: <20040726223832.3edafe0a.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is this a known problem ?  I can't compile the kernel 2.6.7 with gcc 3.4.1:

  CC      arch/ppc/kernel/traps.o
arch/ppc/kernel/traps.c: In function `AltivecUnavailException':
arch/ppc/kernel/traps.c:650: warning: unsigned int format, long unsigned int arg (arg 3)
arch/ppc/kernel/traps.c: In function `AltivecAssistException':
arch/ppc/kernel/traps.c:665: warning: implicit declaration of function `emulate_altivec'
  CC      arch/ppc/kernel/irq.o
  CC      arch/ppc/kernel/idle.o
  CC      arch/ppc/kernel/time.o
{standard input}: Assembler messages:
{standard input}:161: Error: Unrecognized opcode: `mftb'
{standard input}:393: Error: Unrecognized opcode: `mftb'
{standard input}:538: Error: Unrecognized opcode: `mftb'
{standard input}:728: Error: Unrecognized opcode: `mftb'
{standard input}:839: Error: Unrecognized opcode: `mftb'
{standard input}:1054: Error: Unrecognized opcode: `mftbu'
{standard input}:1055: Error: Unrecognized opcode: `mftb'
{standard input}:1056: Error: Unrecognized opcode: `mftbu'
make[1]: *** [arch/ppc/kernel/time.o] Error 1
make: *** [arch/ppc/kernel] Error 2
[root@Jay linux-2.6.7]#


I have no problems with gcc 3.3.3.

(dual-G4 MDD)

--
Giuliano.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
