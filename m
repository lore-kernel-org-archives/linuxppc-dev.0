Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: uart problem
Date: Wed, 17 Sep 2003 09:47:37 +0800
Message-ID: <9733CD15FD6A2C418132CE83BCDB16F60155CE25@hzmail1.cn.utstar.com>
From: "He Xudong" <xdhe@utstar.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all:

	I'm using the eldk linux-2.4.4 kernel.
	I use the 2 SMC and 3 SCC (SCC2,SCC3,SCC4) in 8260_io/uart.c.
change the rs_table,io configuration,and the brg.
mknod ttyS0 c 4 64
mknod ttyS1 c 4 65
mknod ttyS2 c 4 66
mknod ttyS3 c 4 67
mknod ttyS4 c 4 68

and I use the SMC1 to console.
when I
echo test >/dev/ttyS0,
it echoed.

when I
echo test >/dev/ttyS2,
the "test" show on the terminal that i connected to the serial.
but when I
cat /dev/ttyS2,and send some chars from the terminal,nothing happened.
the /proc/interrupts recorded the recieve interrupt,and my printk also
say that.but the recieve_chars found empty bd.

I have use the oscillograph to see if the signal have reach the 8260,
it is.and so does my SMC2.(the SCC4 even have no interrupt).whould you
please give me some advice about it,thx a lot.

Best regards

xdhe

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
