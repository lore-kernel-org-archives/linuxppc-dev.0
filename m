Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3275EDE990
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 03:08:08 +1000 (EST)
From: John Rigby <jrigby@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/2] powerpc: pci cleanup [rev2]
Date: Thu, 26 Jun 2008 11:07:55 -0600
Message-Id: <1214500077-9254-1-git-send-email-jrigby@freescale.com>
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
    Thanks to Michael Ellerman for his comments.  This new version
    calls the new config var PPC_PCI_CHOICE instead of PPC_HAS_PCI
patch 2/2 moves mpc83xx_add_bridge to fsl_pci.c
    This is unchanged.
