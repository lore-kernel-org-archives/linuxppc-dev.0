Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 38B85DDF25
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 16:49:34 +1100 (EST)
Received: from localhost.localdomain (yow-pgortmak-d1.ottawa.windriver.com
	[128.224.146.65])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m095nWmL008497
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 21:49:33 -0800 (PST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Cc: 
Subject: [PATCH 0/3] Powerpc support for SBC834x board
Date: Wed,  9 Jan 2008 00:49:29 -0500
Message-Id: <11998577723665-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following three patches add support for the Wind River SBC834x board
into arch/powerpc.  The support is primarily based on the existing Fsl
MPC834x_MDS board support.  

1) Add support for Wind River SBC834x boards

 b/arch/powerpc/platforms/83xx/Kconfig   |    9 ++
 b/arch/powerpc/platforms/83xx/Makefile  |    1 
 b/arch/powerpc/platforms/83xx/sbc834x.c |  117 +++++++++++++++++++++++++++++++-
 3 files changed, 125 insertions(+), 2 deletions(-)


2) Add device tree source (v1) for Wind River SBC834x board

 b/arch/powerpc/boot/dts/sbc8349.dts |  248 +++++++++++++++++++++++++++++++++++-
 1 file changed, 247 insertions(+), 1 deletion(-)


3) Add default config file for Wind River SBC8349 board

 b/arch/powerpc/configs/sbc834x_defconfig |  801 ++++++++++++++++++++++++++++++-
 1 file changed, 800 insertions(+), 1 deletion(-)


I've tested this with u-boot 1.3.1 + the three recent minor sbc834x u-boot
patches I'd put out plus the latest dtc from git, and it all seems happy.

Paul.
