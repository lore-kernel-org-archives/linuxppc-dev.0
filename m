Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id B1951DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 21:40:02 +1100 (EST)
Date: Thu, 15 Mar 2007 11:39:59 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 0/5 v2] MPC5200 and Lite5200b low power modes
Message-ID: <20070315103959.GA22215@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

Some fixes, improvements from last time:
- saving/restoring of some registers inside sleep code
  (so bestcomm and pic patches can be dropped, yay)
- improvements in FEC code for deep-sleep
- set up wakeup GPIO so Efika can wake too
- patch against latest u-boot (doh)


Patches are based on latest mainline git tree + fec patches:
Fec_MPC5200_eth_driver.patch
Copy_bestcomm_support_files_into_arch_powerpc.patch
Make_FEC_work_on_the_lite5200.patch

This patchset includes the following patches:
- [PATCH 1/5] mpc52xx suspend: UART
- [PATCH 2/5] mpc52xx suspend: FEC (ethernet)
- [PATCH 3/5] mpc52xx suspend: USB
- [PATCH 4/5] mpc52xx suspend: deep-sleep
- [PATCH] icecube/lite5200b: wakeup from low-power support
- [PATCH 5/5] lite5200b suspend: low-power mode


	Domen
