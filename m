Return-Path: <lpetras@netspace.net.au>
Received: from mail.netspace.net.au (whirlwind.netspace.net.au [203.10.110.76])
	by ozlabs.org (Postfix) with ESMTP id 00EBC67A46
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Feb 2005 04:33:25 +1100 (EST)
Received: from supernova (220-253-48-46.VIC.netspace.net.au [220.253.48.46])
	by mail.netspace.net.au (Postfix) with ESMTP id 3103B10CB4F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Feb 2005 04:13:01 +1100 (EST)
From: "Linas Petras" <lpetras@netspace.net.au>
To: <linuxppc-embedded@ozlabs.org>
Date: Sat, 5 Feb 2005 04:13:01 +1100
Message-ID: <000001c50adc$c814dae0$6401a8c0@supernova>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Problems with Serial Port on IceCube 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All

I'm running Sylvain Munaut's version of 2.6.10-rc2 with DENX's 3.1 ELDK =
as
the cross
compile tools with nfs mounted root filesystem and I seem to have a =
probelm
when I'm=20
connected to the "icecube" development boards serial port.

I get the u-boot 1.1.3 bootrom messages from the serial port on the
"icecube" and can=20
boot the kernel using the serial port but I don't get any messages after =
the
early=20
boot message "arch: exit". It appeared to me that the board was booting =
so I
tried to=20
telnet via the network to the board and this worked fine. So the kernel =
is
running, I=20
just don't get the "normal" bootup messages from the kernel.

If I use the standard DENX 2.4.25 kernel I get all the message going to =
the
serial=20
port OK.

Any ideas of whats going on ????? Is their a problem with the console
support in=20
Sylvain's port or something in the "standard" init scripts that come =
with
DENX's ELDK=20
3.1 when used with a 2.6.xx kernel or have I missed something obvious?

Linas Petras
------------
I know not with which weapons World War III will be faught, but World =
War IV
will be faught with sticks and stones. - Albert Einstein.
