Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E37CB15.50307@imc-berlin.de>
Date: Wed, 29 Jan 2003 13:37:41 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: I2C RTC with MPC8xx?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

what do I have to do to use an I2C RTC (like Dallas DS1337) within LinuxPPC?

I know there're drivers for PPCBoot / U-Boot.

But how could I access them from Linux?

drivers/char/rtc_8xx.c is not suitable.

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
