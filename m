Message-ID: <3E37996A.40302@imc-berlin.de>
Date: Wed, 29 Jan 2003 10:05:46 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: problems with MPC8xx internal RTC !?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I am using an MPC855T, external clocked with 16 MHz. Using the internal PLLs it
runs at 80MHz/40Mhz. An 32.768KHZ crystal is connected to clock the MPCs
internal RTC. A battery is there as well.

All seems to be fine. But I realized that the RTC runs too fast. It seems to be
releated to systems restarts.

It tested. After 25 reboots the RTC is already SIX seconds ahead!!!

rdate:   Wed Jan 29 10:03:58 2003
date:    Wed Jan 29 10:04:04 CET 2003
hwclock: Wed Jan 29 10:04:04 2003  0.000000 seconds

Any ideas?

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
