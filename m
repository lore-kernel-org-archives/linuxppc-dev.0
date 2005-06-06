Return-Path: <colui77@virgilio.it>
Received: from vsmtp14.tin.it (vsmtp14.tin.it [212.216.176.118])
	by ozlabs.org (Postfix) with ESMTP id EBC8B679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 00:15:31 +1000 (EST)
Received: from ims2a.cp.tin.it (192.168.70.102) by vsmtp14.tin.it (7.0.027)
	id 429D6F26001DED31 for linuxppc-embedded@ozlabs.org;
	Mon, 6 Jun 2005 16:15:28 +0200
Date: Mon, 6 Jun 2005 16:15:28 +0200
Message-ID: <4293EE1500020957@ims2a.cp.tin.it>
From: colui77@virgilio.it
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Subject: help with ML300
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,
I'm working with the xilinxs ML300,. My board runs the montavista linux
2.4.21 shipped with the board. Here the xilinx_gpio.o moeule maps only th=
e
GPIO 1. I have downloaded the montavista linux 2.4.30 and I'd like rebuil=
ding
the xilinx_gpio module cause I need the GPIO2. I have substituted the xil=
inx_gpio.o
module on the board with the builded one...but when insmod-ing it I have
the following errors:
unresolved symbol misc_register_R30927432
unresolved symbol misc_deregister_Re3fc4e19
I have no idea about what to do ....
please help me :-(
Luigi
