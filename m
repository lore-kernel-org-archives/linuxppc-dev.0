Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43318B7010
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 16:48:00 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 02:47:57 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5T6ltSh412846
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 02:47:55 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5T6ls4u006777
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 02:47:55 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V5 0/7] minimal alignment for p2p bars
Date: Fri, 29 Jun 2012 14:47:43 +0800
Message-Id: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linuxram@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v1 -> v2:
	* Shorten the varaible names so that they looks more short.
	* Changelog adjustment so that they looks more meaningful.

v2 -> v3:
	* Rebase to 3.5.RC4

v3 -> v4:
	* Merge Yinghai's patches.

v3 -> v4:
	* Split patch for easy review.
	* Add function to retrieve the minimal alignment of p2p bridge. 

Lu Yinghai(3):
  pci: change variable name for find_pci_host_bridge
  pci: argument pci_bus for find_pci_host_bridge
  pci: fiddle with conversion of pci and CPU address

Gavin Shan(4)
  pci: make find_pci_host_bridge global
  pci: minimal alignment for bars of P2P bridges
  pci: function to retrieve alignment of p2p bars
  pci: resource assignment based on p2p alignment

 drivers/pci/host-bridge.c |   59 ++++++++++++++++++++++++++++++++++++---------
 drivers/pci/probe.c       |    5 ++++
 drivers/pci/setup-bus.c   |   22 +++++++++++------
 include/linux/pci.h       |   15 +++++++++++-
 4 files changed, 81 insertions(+), 20 deletions(-)

Thanks,
Gavin
