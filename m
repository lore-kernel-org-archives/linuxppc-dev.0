Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB770DFDA3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 06:19:36 +1000 (EST)
From: John Rigby <jrigby@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/2] powerpc: pci cleanup
Date: Wed, 25 Jun 2008 14:19:22 -0600
Message-Id: <1214425164-1267-1-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

patch 1/2 cleans up powerpc pci config
patch 2/2 moves mpc83xx_add_bridge to fsl_pci.c
