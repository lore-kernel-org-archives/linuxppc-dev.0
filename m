Message-ID: <011801c07f12$bf037e70$4a1f76d8@washington>
From: "Navin Boppuri" <nboppuri@trinetcommunication.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Serial driver help
Date: Mon, 15 Jan 2001 16:46:45 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Can someone tell me where I can find some documentation on how to write a
serial driver in linux using the serial.h and tty data structures? I am
using MAX3100 uart connected to the SPI controller. The SPI driver is fine
works just fine. I do see that uart.c is written for uarts connected on SMC
and SCC. All I need to do is to port it for SPI.

Thank you,
Navin Boppuri


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
