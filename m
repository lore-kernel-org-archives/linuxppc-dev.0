Message-ID: <20020816171017.28307.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
From: "Pete Smithers" <petesmithers@mail.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 16 Aug 2002 12:10:17 -0500
Subject: redwood5
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi

i am trying to build a kernel from linuxppc_2_4_devel for the redwood5 board.
there seems to have been some restructuring in that tree after which nobody probably compiled a kernel for that board. at least, when i select gpio, onchip ethernet, onchip ide or sicc serial port i get a bunch of errors, like
ibm_ocp_gpio.c:124: `DCRN_CHCR0' undeclared (first use in this function) etc.

from a naive point of view, the fix, at least  for this particular error would be to #include asm/ibm403.h and above that one of the headers in arch/ppc/platforms that #define DCRN_CHCR_BASE, depending on the selected processor.

but i don't think ibm_ocp_gpio.c should care about the selected processor, there must be some other way, to do that in a more generic way, so the other files that currently fail to compile won't fail anymore as well :)

i am just too new to the ppc stuff, so i am asking you gurus what you would preferably do to fix the problem...


Greets,
Pete
--
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
