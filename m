Message-ID: <3E6375D4.3010405@esd-electronics.com>
Date: Mon, 03 Mar 2003 16:33:40 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: register_serial on 405 platform
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I need to register some non-standard serial 16550 UART ports
on a 405GP platform. I noticed that the rs_table in drivers/char/serial.c
has only two entries (used by the on-chip serial ports). So I cannot understand
how I can register further ports without changing the kernel source.

Am I right, that it is currently not possible to register further serial ports
with the 2_4_devel tree on 405 platforms?

Matthias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
