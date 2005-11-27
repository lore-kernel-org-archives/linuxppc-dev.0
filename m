Return-Path: <BLandau@nds.com>
Received: from ILEX5.IL.NDS.COM (jeru1.ndsisrael.com [192.118.34.248])
	by ozlabs.org (Postfix) with ESMTP id B4441681BE
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Nov 2005 21:34:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Sun, 27 Nov 2005 12:22:20 +0200
Message-ID: <02AA386EB831044F8537A696BA785C7807645A@ILEX5.IL.NDS.COM>
From: "Landau, Bracha" <BLandau@nds.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: kernel 2.6.14 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I'm trying to move to the latest kernel release from linux 2.6.13.4 on =
the MPC8272ADS board.
2.6.13.4 works, but from 2.6.14 and up (I don't know where from 2.6.13.4 =
to 2.6.14 the problem starts) the kernel crashes on bootup with the =
message=20
"Kernel BUG in ppc_sys_init at arch/ppc/syslib/ppc_sys_init.c:131"
Anyone know how to fix this problem?
