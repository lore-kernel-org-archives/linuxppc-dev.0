Message-ID: <534be22204081812574594026b@mail.gmail.com>
Date: Wed, 18 Aug 2004 16:57:11 -0300
From: Sulamita Garcia <toskinha@gmail.com>
Reply-To: Sulamita Garcia <toskinha@gmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC855T
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I'm trying to compile a ppc kernel and having some problems. I
followed the http://penguinppc.org/embedded/ and installed gcc and
binutils to powerpc. When I try compile 2.6.7 kernel, I had this:

  CC      arch/ppc/kernel/traps.o
In file included from arch/ppc/kernel/traps.c:29:
include/linux/interrupt.h:47: error: parse error before '(' token
include/linux/interrupt.h:47: warning: function declaration isn't a prototype
include/linux/interrupt.h:47: error: parse error before '*' token
include/linux/interrupt.h:47: error: `irqreturn_t' declared as
function returning a function
include/linux/interrupt.h:47: warning: function declaration isn't a prototype
include/linux/interrupt.h:47: error: 'irqreturn_t' redeclared as
different kind of symbol
include/asm/mpc8xx.h:99: error: previous declaration of 'irqreturn_t' was here
include/linux/interrupt.h:47: error: parse error before "unsigned"
arch/ppc/kernel/traps.c: In function `AltivecUnavailException':
arch/ppc/kernel/traps.c:650: warning: unsigned int format, long
unsigned int arg (arg 3)
make[1]: *** [arch/ppc/kernel/traps.o] Error 1
make: *** [arch/ppc/kernel] Error 2

When I let the kernel config to 6xx/7xx/74xx/8260 processor, I'm able
to compile the kernel without problems. When I change to 8xx
processor, I got this error.

I'm trying set am cross compile enviroment to MPC855T box. Can you
give some light?
Thanks
--
-------------------------------------------------------------
  °v°  Sulamita Garcia
 /(_)\  LinuxChix Brasil
 ^ ^  http://www.linuxchix.org.br/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
