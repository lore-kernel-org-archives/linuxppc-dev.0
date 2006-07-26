Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id CD3B967A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jul 2006 07:45:31 +1000 (EST)
Subject: Serial issue
From: Lee Revell <rlrevell@joe-job.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 26 Jul 2006 17:45:23 -0400
Message-Id: <1153950324.2927.6.camel@mindpipe>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to connect to a Yosemite 440 PPC board using the serial
console.  I've tried everything in every Linux Serial FAQ and HOWTO but
no matter what, I can receive but I cannot transmit.

I know the cable is good, and the PPC board seems OK as I can see all
the boot messages.  Could it be a bug in my host's serial port?  I'm
using a Via EPIA M6000.

$ sudo cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:0 tx:0 rx:5379 oe:7 RTS|DTR|DSR|CD

No matter what I do, tx bytes is stuck at 0.  I've tried irq 0 (polling)
and irq 4.  No difference at all.

Help...

Lee
