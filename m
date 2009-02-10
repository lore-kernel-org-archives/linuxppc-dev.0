Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (cyborg3.cyclone.com [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 4C6B6DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 08:43:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: 2.6.27.6 kernel Bad trap boot problem on MPC8568E
Date: Tue, 10 Feb 2009 16:44:45 -0500
Message-ID: <43EB80E07C42E1408726E4905FB96B04C07522@CYBORG3.cyclone.com>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to get a 2.6.27.6 kernel to boot on an MPC8568E processor.  =
The kernel/patches/compiler came from Freescale's LTIB release in =
December 2008.  Using the same kernel source, toolchain, and ramdisk =
image, I can boot and run an SMP kernel on the MPC8572E processor which =
is on the same board.  This is what I see on the 8568E processor:

...
brd: module loaded
loop: module loaded
fsl_pm.ko: loading ...
fsl_pm.ko: no SoC node, ignoring
fsl_pm.ko: hal initialisation
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.4-skbr1.1.4, =
00:80:4d:22:00:66
eth0: MTU =3D 1500 (frame size=3D1524, truesize=3D1800)
eth0: Running with NAPI enabled
eth0: 128/128 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.4-skbr1.1.4, =
00:80:4d:22:40:66
eth1: MTU =3D 1500 (frame size=3D1524, truesize=3D1800)
eth1: Running with NAPI enabled
eth1: 128/128 RX/TX BD ring size
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
EDAC MC: Ver: 2.1.0 Feb  9 2009
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 144k init
Bad trap at PC: 100b7354, SR: 2d000, vector=3D2020
init has generated signal 5 but has no handler for it
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..

I am not using a debugger, so I can't see where the SIGTRAP would be =
coming from.

Thanks in advance,

Scott



___________________________________________________________________=20
=A0 Scott N. Coulter=20
=A0 Senior Software Engineer=20
=A0=20
=A0 Cyclone Microsystems=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
=A0 370 James Street=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Phone:=A0 =
203.786.5536 ext. 118=20
=A0 New Haven, CT 06513-3051=A0=A0=A0=A0=A0 Email:=A0 =
scott.coulter@cyclone.com=20
=A0 =
U.S.A.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Web:=A0=A0=A0 http://www.cyclone.com=20
___________________________________________________________________=20
