Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C7B62C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 22:09:49 +1100 (EST)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] net/phy: Add Cortina CS43xx PHY support
Date: Wed, 5 Mar 2014 11:09:43 +0000
Message-ID: <3d2078f16eac4f59aa62e3bfb4e41d6f@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1394007391-32256-1-git-send-email-Shengzhou.Liu@freescale.com>
 <CFF70C14-23B1-45B9-AD84-C33E32F0B9A3@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "B43619@freescale.com" <B43619@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Abandon this patch, in Kernel gen10g_driver can support Cortina PHY,  we ne=
ed specific PHY driver just in u-boot.

-Shengzhou
