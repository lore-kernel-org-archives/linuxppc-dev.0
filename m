Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 882872C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 05:08:18 +1100 (EST)
Message-ID: <1394042882.2697.196.camel@snotra.buserror.net>
Subject: Re: [PATCH] net/phy: Add Cortina CS43xx PHY support
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <Shengzhou.Liu@freescale.com>
Date: Wed, 5 Mar 2014 12:08:02 -0600
In-Reply-To: <3d2078f16eac4f59aa62e3bfb4e41d6f@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1394007391-32256-1-git-send-email-Shengzhou.Liu@freescale.com>
 <CFF70C14-23B1-45B9-AD84-C33E32F0B9A3@kernel.crashing.org>
 <3d2078f16eac4f59aa62e3bfb4e41d6f@DM2PR03MB398.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Cao Yong Hua-B43619 <B43619@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-05 at 05:09 -0600, Liu Shengzhou-B36685 wrote:
> Abandon this patch, in Kernel gen10g_driver can support Cortina PHY,  we need specific PHY driver just in u-boot.

Why shouldn't U-Boot have a generic driver too?

-Scott
