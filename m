Message-ID: <38107697.9A2576F7@eng.uct.ac.za>
Date: Fri, 22 Oct 1999 16:37:11 +0200
From: Grant Carter <gcarter@eng.uct.ac.za>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC823 Serial ports
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

I am trying to get the second serial port (SMC2) up and running. I have
found that it was removed from arch/ppc/8xx_io/uart.c in the rs_table
struct. I have added this again and now the kernel (2.2.5) seems to find
it on bootup.

CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC

What else do I need to do to get it working as when I echo something to
it, I get nothing out of the port.

Thanks in advance
Grant
-- 
Grant Carter                              gcarter@eng.uct.ac.za
Department of Electrical Engineering      University of Cape Town
Tel: +27 (0)21 650-3467                   Fax: +27 (0)21 650-3465
                     "Coffee not found - operator halted!"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
