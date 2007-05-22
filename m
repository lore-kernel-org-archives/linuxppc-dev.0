Return-Path: <wei.zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0678EDDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 13:31:49 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 0/5] Add the support for MPC8641 silicon rev 2.0 and
	MPC8641HPCN board 2.0
Date: Tue, 22 May 2007 11:38:25 +0800
Message-Id: <11798051102658-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Paul,

The below 5 patches add the support for MPC8641 rev 2.0 silicon and MPC8641HPCN board 2.0.

  [PATCH 1/5] Remove the errata fix codes for MPC8641 silicon ver 1.0 which is end of life.
  [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
  [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
  [PATCH 4/5] Set RC of mpc8641 to transparent bridge for transfer legacy I/O access.
  [PATCH 5/5] Set IDE in ULI1575 to not native mode.

The MPC8641 rev 2.0 silicon fix the PCI/PCI-Express errata in rev 1.0. And the rev 1.0 silicon is end of life. So the dts tree and codes should be changes. Codes which are not compatible with PCI/PCI-Express specifications are removed. Some minor issues are fixed.

Thanks!

Best Regards,
Zhang Wei
