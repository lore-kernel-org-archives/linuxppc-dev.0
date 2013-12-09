Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:6])
 by ozlabs.org (Postfix) with ESMTP id 53ADE2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 18:17:19 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: benh@kernel.crashing.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 0/3] powerpc iommu: Remove hardcoded page sizes
Date: Mon,  9 Dec 2013 18:17:00 +1100
Message-Id: <1386573423-7989-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series doesn't actually change the iommu page size as each platform continues to
initialise the iommu page size to a hardcoded value of 4K.

At this stage testing has only been carried out on a pSeries machine, other platforms
including cell have yet to be tested.

Changes from V1:
* Rebased on Ben's next tree
* Updated constants in 1/3 that were not present in V1 (thanks Alexy!)
* Added initialisation for pasemi platform that was missed in V1
