Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:7])
 by ozlabs.org (Postfix) with ESMTP id 8089F2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 15:22:06 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] powerpc iommu: Remove hardcoded page sizes
Date: Mon, 11 Nov 2013 15:22:06 +1100
Message-Id: <1384143729-14491-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series replaces the hardcoded iommu page sizes used by the iommu
backend with a dynamic page size initialised by each platform. This will make
it easier to use iommu page sizes other than 4K.

The series doesn't actually change the iommu page size as each platform continues to
initialise the iommu page size to a hardcoded value of 4K.

At this stage testing has only been carried out on a pSeries machine, other platforms
including cell have yet to be tested.
