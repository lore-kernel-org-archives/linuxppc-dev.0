Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 59BA6B7CB9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 13:13:21 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: netdev@vger.kernel.org
Subject: [net-next-2.6 PATCH 0/3] Support for MPC512x FEC
Date: Thu, 21 Jan 2010 03:13:16 +0100
Message-Id: <1264039999-25731-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches attempt to provide support for the Freescale MPC512x
FEC in the fs_enet driver. The first cleanup patch replaces printk
by dev_xxx. The second and third attemt to support MPC5121 FEC
in the FEC driver. The first version of the last two patches
was previously submitted as part of the patch series for updated
MPC5121 support. Now these are separated and also address comments
to the first version. Additionally a cleanup patch is added
to this new series. The patches are based on net-next-2.6.

[1/3] fs_enet: use dev_xxx instead of printk
[2/3] fs_enet: Add support for MPC512x to fs_enet driver
[3/3] fs_enet: Add FEC TX Alignment workaround for MPC5121

The code has been tested on the Freescale/STX "MPC5121ADS" board
(board rev. 4) with a MPC5121e Rev. 2.

Cc: <linuxppc-dev@ozlabs.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
