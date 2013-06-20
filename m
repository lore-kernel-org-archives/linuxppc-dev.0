Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C5D82C023D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 20:24:17 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 04:13:35 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 27FE91FF001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 04:08:18 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5KADWn0118372
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 04:13:32 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5KADVE7030219
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 04:13:32 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 0/5] EEH Support for PowerNV platform
Date: Thu, 20 Jun 2013 18:13:21 +0800
Message-Id: <1371723206-26190-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


It resends the last 5 patches ([27/31] - [31/31]) of the series to support EEH
for PowerNV platform.

v6 -> v7:
	* Use atomic notifier to replace the original OPAL notifier according
	  to Ben's suggestion.
	* Avoid registering duplicated notifiers for OPAL_EVENT_PCI_ERROR.

---

arch/powerpc/include/asm/opal.h           |    5 ++
arch/powerpc/platforms/powernv/eeh-ioda.c |   72 ++++++++++++++++++++++++++++-
arch/powerpc/platforms/powernv/opal.c     |   69 +++++++++++++++++++++++++++-
arch/powerpc/platforms/powernv/pci-ioda.c |   23 +++++++++
arch/powerpc/platforms/powernv/pci.h      |    4 ++
arch/powerpc/platforms/powernv/setup.c    |    4 ++
6 files changed, 175 insertions(+), 2 deletions(-)

Thanks,
Gavin
