Message-ID: <3850EFAE.2E127301@eng.uct.ac.za>
Date: Fri, 10 Dec 1999 14:18:54 +0200
From: Grant Carter <gcarter@eng.uct.ac.za>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Serial ports
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

I posted a question a while ago to the list about not being able to get
the second serial port ttyS1 (on SMC2) working on my BSE-IP board
running the 2.2.5. The kernel finds the port but when I echo something
to it, nothing comes out of the port. I received some replies but
nothing that was suggested has worked. Could someone please suggest how
I can test the second serial port and then hopefully get it working.
Below are the things that I have tried so far:

I added SMC2 to the rs_table in arch/ppc/8xx_io/uart.c and the kernel
detected the port.
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC

I have made sure that there is the correct device nodes in /dev 
# ls -la ttyS*
crw-r--r--   1 root     0          4,  64 Sep  7  1998 ttyS0
crw-rw----   1 root     66         4,  65 Dec 10  1999 ttyS1

Does anyone have any ideas where I can go from here. I am not 100% that
the hardware is working so perhaps that could be the problem.

Many thanks in advance
Grant


-- 
Grant Carter                              gcarter@eng.uct.ac.za
Department of Electrical Engineering      University of Cape Town
Tel: +27 (0)21 650-3467                   Fax: +27 (0)21 650-3465
                     "Coffee not found - operator halted!"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
