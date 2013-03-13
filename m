Return-Path: <dedekind1@gmail.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id 5B4972C029B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 20:04:04 +1100 (EST)
Message-ID: <1363165492.9457.10.camel@sauron.fi.intel.com>
Subject: [PATCH 00/10] mtd: remove dead map drivers
From: Artem Bityutskiy <dedekind1@gmail.com>
To: MTD Maling List <linux-mtd@lists.infradead.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 13 Mar 2013 11:04:52 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Adding the PPC list]

This patch-set removes a bunch of dean MTD map drivers. The way I judged
whether a driver is dead or not was looking at driver's dependencies in the
Kconfig file. Whenever I saw a driver depending on a Kconfig symbol which is
not defined anywhere, I treated the driver as dead.

The motivation for this patch-set is to clean up the MTD subsystem a little and
lessen the maintenance burden. Indeed, the less drivers we have, the easier it
is to do MTD framework refactoring.

Thanks,
Artem.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

-- 
Best Regards,
Artem Bityutskiy
