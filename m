Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 915CB1A0427
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 08:14:42 +1100 (AEDT)
Date: Thu, 26 Mar 2015 16:14:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: <stable@vger.kernel.org>
Subject: stable: Please include commit bb344ca5b90 ("powerpc/mpc85xx: Add
 ranges to etsec2 nodes")
Message-ID: <20150326211427.GA20872@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit bb344ca5b90df6 ("powerpc/mpc85xx: Add ranges to etsec2 nodes")
fixes a bug that was exposed by commit 746c9e9f92dd ("of/base: Fix
PowerPC address parsing hack").  The latter commit was applied to stable
trees, so the former should be as well.

-Scott
