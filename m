Message-ID: <3F2949D3.8020106@windriver.com>
Date: Thu, 31 Jul 2003 17:54:43 +0100
From: Richard Danter <richard.danter@windriver.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 750/107 CHRP question
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

Sorry if this is a bit of a newbie question....

I am trying to port a 2.4.x kernel to a PPC750 board with a 107
controller. The board has a serial port connected to one of the ROM
select lines (at 0x7C000000) and I would like to use this as my console
port.

So far I can boot the board and see (via the serial port) the kernel
load addresses etc, and the kernel gets decompressed and starts to run.
This is all fine as the MMU is off at this point. However, when the
serial_console_setup() code starts trying to configure the serial port
again, I get a kernel panic as I am accessing an invalid mem space (MMU
now on!).

How do I map this correctly???

My build is based on the sandpoint but with all the init stuff for
devices, such as the RTC, removed. So I have the "standard" mapping in
the MMU_init code.

Many thanks
Rich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
