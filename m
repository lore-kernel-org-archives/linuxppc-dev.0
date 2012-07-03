Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB9102C00EB
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2012 17:01:40 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 3 Jul 2012 01:01:38 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 16A251FF0050
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2012 07:01:34 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6371Da7230564
 for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2012 01:01:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6371AEP017022
 for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2012 01:01:13 -0600
Date: Tue, 3 Jul 2012 15:01:06 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 0/7] minimal alignment for p2p bars
Message-ID: <20120703070106.GA13892@shangw>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxram@us.ibm.com, linuxppc-dev@ozlabs.org,
 bhelgaas@google.com, yinghai@kernel.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bjorn,

Could you please review it when you have time?

Thanks,
Gavin

>v1 -> v2:
>	* Shorten the varaible names so that they looks more short.
>	* Changelog adjustment so that they looks more meaningful.
>
>v2 -> v3:
>	* Rebase to 3.5.RC4
>
>v3 -> v4:
>	* Merge Yinghai's patches.
>
>v3 -> v4:
>	* Split patch for easy review.
>	* Add function to retrieve the minimal alignment of p2p bridge. 
>
>Lu Yinghai(3):
>  pci: change variable name for find_pci_host_bridge
>  pci: argument pci_bus for find_pci_host_bridge
>  pci: fiddle with conversion of pci and CPU address
>
>Gavin Shan(4)
>  pci: make find_pci_host_bridge global
>  pci: minimal alignment for bars of P2P bridges
>  pci: function to retrieve alignment of p2p bars
>  pci: resource assignment based on p2p alignment
>
> drivers/pci/host-bridge.c |   59 ++++++++++++++++++++++++++++++++++++---------
> drivers/pci/probe.c       |    5 ++++
> drivers/pci/setup-bus.c   |   22 +++++++++++------
> include/linux/pci.h       |   15 +++++++++++-
> 4 files changed, 81 insertions(+), 20 deletions(-)
>
>Thanks,
>Gavin
>
