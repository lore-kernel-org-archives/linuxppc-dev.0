Return-Path: <Lindner@pandacomdirekt.de>
Received: from pandacomcsrv.pandacom.de (pandacomcsrv.pandacom.de
	[194.45.104.6]) by ozlabs.org (Postfix) with SMTP id A72F5DDD01
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 23:39:23 +1100 (EST)
Received: from ffmpdd1.pandacomdirekt.de ([172.17.69.60])
	by pandacomcsrv.pandacom.de (SMSSMTP 4.1.0.19) with SMTP id
	M2007111513243108721
	for <linuxppc-embedded@ozlabs.org>; Thu, 15 Nov 2007 13:24:39 +0100
Subject: /sbin/init: error while loading shared libraries: libm.so.6:cannot
	open shared object file: No such file or directory [Scanned]
From: "Lindner" <lindner@pandacomdirekt.de>
To: <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 15 Nov 2007 13:24:00 +0100
Message-ID: <1195129440.10980.7.camel@linux-2drc.site>
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have a problem with booting the uRamdisk image from eldk 4.1 on an
TQM5200 (MPC5200 CPU) board.
I have taken the uRamdisk image from the "/eldk/ppc_6xx/images" folder
and copied it to the flash. After booting the following output came
after the Kernel boot:

Freeing unused kernel memory: 64k init
/sbin/init: error while loading shared libraries: libm.so.6: cannot open
shared object file: No such file or directory
Kernel panic: Attempted to kill init!
 <0>Rebooting in 1 seconds..


An image from eldk 3.1.1 is working fine with the Kernel 2.4.25.
The files libm.so.6 and libm-2.3.5.so are available in the /lib folder.

Does anyone has an idea, what this could be?

Thanks,
Michael
