Message-ID: <13535.216.110.51.8.1081275800.squirrel@www.orkun.us>
Date: Tue, 6 Apr 2004 13:23:20 -0500 (CDT)
Subject: DS1307/1338 RTC driver?
From: "Tolunay Orkun" <listmember@orkun.us>
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anyone have a working Dallas/Maxim DS1307/1338 driver for Linux?

This an RTC chip with I2C interface.

My aim is get /dev/rtc functional so I can use hwclock with busybox...

I have found that LM-Sensors do include an DS1307 driver but I am not sure
how to integrate it (if it is possible). I also do not want bloat.

I've also found another ds1307 driver attached to a list message
(elsewhere) but could not get it to compile properly.

FYI, I am using 2.4.25-pre4 from linuxppc-2.4 BitKeeper trees. The
processor is IBM PPC405GP. Board is Cogent CSB272. I am using
drivers/i2c/i2c-ibm_iic.c (CONFIG_I2C_IBM_IIC=y)

I appreciate any help or pointers.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
