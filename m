Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Dmitriy.Zavin@infineon.com
Message-ID: <FD90897E35ABD311AE0E0008C7E6404A07192EDE@ca02exch4.sjc.infineon.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: SCC2 and SCC3 serial ports on RPX Classic (MPC860)
Date: Wed, 26 Mar 2003 11:17:18 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hey all,

I'm using the Embedded Planet RPX Classic LF SBC (MPC860 onboard).
I compiled the 2.4.7 kernel (from TimeSYS) with SCC2 and SCC3 enabled for IO. I have a break-out board where I manually hook into the TXD/RXD/GND pins (Port A, pins 12/13). Now, I'm sending a pattern (FOOOOOO) from the SBC to /dev/tts/1 (SCC2) which is connected to a windows box on COM1. All I get on COM1 is garbage. But its not random. I made sure to set all the baud/stop bits/parity manually through IOCTL calls to make sure its right, but still no go. And SCC3 (/dev/tts/2) is completely unresponsive. Writing data to it always blocks the program. I have to ^C, because nothing shows up on the other side of the serial link. Its very puzzling.

Do I have to hook up all the CTS/RTS lines in order to get it to work? I thought that TX/RX/GND was enough?

Any ideas??

Thanks a lot in advance.

--Dima

Some info:

CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
