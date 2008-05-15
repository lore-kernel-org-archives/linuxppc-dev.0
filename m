Return-Path: <john.bonesio@xilinx.com>
Received: from outbound1-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EF429DDFB8
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 04:39:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Using GPIO
Date: Thu, 15 May 2008 11:39:08 -0700
In-reply-to: <02f401c8b6a9$b1e062e0$ad289e86@LPSC0173W>
References: <02f401c8b6a9$b1e062e0$ad289e86@LPSC0173W>
From: "John Bonesio" <john.bonesio@xilinx.com>
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>,
	<linuxppc-dev@ozlabs.org>
Message-Id: <20080515183910.6B40A75007E@mail106-va3.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Guillaume,

If you're using arch/powerpc, my understanding is that
CONFIG_XILINX_GPIO needs to be enabled as well as having the right info
in the dts file.

Right now I'll have to defer to others to tell you what's needed in the
dts file.

If you're using arch/ppc, I believe you just need CONFIG_XILINX_GPIO
enabled.

When the system boots up, you see a message on the console when the GPIO
driver initializes.

This is not exactly a tutorial. Hopefully this still helps,

- John

-----Original Message-----
From: linuxppc-dev-bounces+john.bonesio=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-bounces+john.bonesio=3Dxilinx.com@ozlabs.org] On
Behalf Of Guillaume Dargaud
Sent: Thursday, May 15, 2008 9:35 AM
To: linuxppc-dev@ozlabs.org
Subject: Using GPIO

Hello all,
I'm trying to use the Xilinx GPIO from a user program.
Since I haven't managed to compile their example (simon.c is given
without a=20
makefile), I wanted to try using /dev/gpio...

So I added
/dev/gpio0  c  666  0  0  10  185 -  -  -
to device_table.txt when I generated my root filesystem with buildroot,
but=20
apparently this leads nowhere as it's not visible in /proc/devices.

Is there some example or tutorial on how to use CONFIG_XILINX_GPIO ?
Either=20
as a device or as API calls...
--=20
Guillaume Dargaud
http://www.gdargaud.net/


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be=
 proprietary, privileged or copyrighted under applicable law. If you are=
 not the intended recipient, do not read, copy, or forward this email=
 message or any attachments. Delete this email message and any attachments=
 immediately.
