Message-ID: <3EDEA1A3.6080805@bmrtech.com>
Date: Thu, 05 Jun 2003 09:49:23 +0800
From: =?GB2312?B?varT8bn6?= <jiang.y.g@bmrtech.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, dan@mvista.com
Subject: MPC860 and Compact Flash Card in True Ide Mode
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello ,

Dan wrote in returning SangTae Ha "MPC850 and ATA/IDE"
>There are at least three easy and inexpensive ways people add ATA/IDE
>to the 8xx processors for embedded systems:

>Connect to PCMCIA interface
>Use a simple CPLD between the processor bus and disk
>Program one of the UPMs to generate timing and then
>externally buffer the signals

I use the third way (UPMB) to add ATA/IDE (SanDisk 16M) to Mpc860T for
my embedded system and OS is MVL PE3.0 in my board.
According to MPC860UM, Program the UPMs in the following steps:
1. Write patterns into the RAM array.
2. Program MPTPR
3. Program the machine mode register (MAMR and MBMR).
4. Set up BRx and ORx.

But I have a difficulty to write patterns into the RAM array because I
know little UPM timing. Who can give me a RAM table and MPTPR, MBMR example?

Thanks in advance!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
