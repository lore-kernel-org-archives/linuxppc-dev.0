Message-ID: <001201c29163$3d2e9cd0$faffa8c0@VISHWANATH>
From: "Vishwanath" <vishwanath@mistralsoftware.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: I2C Device Register Read problem in 440GP
Date: Thu, 21 Nov 2002 19:08:13 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I have written custom driver for accessing a device sitting on the I2C bus
of IBM 440GP. I am operating in the master mode of I2C controller of 440GP.
I was able to write a particular value onto the device register. But when I
try to read the value back, it is returning 0. I have disabled the
interrupts.

When I was debugging, I found that data was arriving on the I2C bus. But
before I could read the Master Data Buffer Register of 440 GP, the register
is getting cleared. Does anyone no why?

Pls help me. I am stuck.

Thanks and regards,
vishwa


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
