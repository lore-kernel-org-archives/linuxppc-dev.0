Message-ID: <3BCC7F5C.A8F12E7E@prodys.net>
Date: Tue, 16 Oct 2001 20:41:32 +0200
From: Pedro Parrilla <pparrilla@prodys.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Using KDBG in remote debugging with MBX860...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Could anyone tell me why I couldn't communicate with the KDBG Kernel
in my MBX860 target (Kernel 2.4.7 for PPC, Har Hat Linux 1.2
distribution), from my Intel Pc host, when the init program is run?
Before init program is run everything is OK, but after that, KGDB and
GDB don't communicate. I've solved that in a very poor manner... I
thought that serial ports are initialized by /sbin/init or somewhere in
kernel booting, droppping down the serial KGDB channel, so I put away
rs_8xx_open and rs8xx_close from uart.c and everything now is Ok (I
don't have console but it doesn't matter to me, I use telnet from Intel
Pc Host)...I don't know about the Kernel, and I'd like somebody would
give me a better (cleaner) way to solve this. Thank you in advance.Bye

--
Pedro Parrilla Jimena           Prodys.S.L
Embedded systems programming    Trigo,54
e-mail pparrilla@prodys.net     Leganes(Madrid) 28914
Tel.:+34916896880               http://www.prodys.net


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
