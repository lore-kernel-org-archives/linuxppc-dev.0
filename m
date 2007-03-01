Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id D4563DDEC7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 18:53:29 +1100 (EST)
Date: Thu, 1 Mar 2007 08:53:23 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 0/7] MPC5200 and Lite5200b low power modes
Message-ID: <20070301075323.GP4397@moe.telargo.com>
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

Patches are based on latest mainline git tree + fec patches:
Fec_MPC5200_eth_driver.patch
Copy_bestcomm_support_files_into_arch_powerpc.patch
Make_FEC_work_on_the_lite5200.patch


This patchset includes the following patches:
- [PATCH 1/7] mpc52xx suspend: bestcomm
- [PATCH 2/7] mpc52xx suspend: UART
- [PATCH 3/7] mpc52xx suspend: FEC (ethernet)
- [PATCH 4/7] mpc52xx suspend: USB
- [PATCH 5/7] mpc52xx suspend: deep-sleep
- [PATCH 6/7] lite5200b suspend: PIC
- [u-boot patch] support lite5200b wakeup in u-boot
- [PATCH 7/7] lite5200b suspend: low-power mode


I would appreaciate any comments, suggestions etc.


	Domen
