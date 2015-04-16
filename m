Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 75A051A0928
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 05:46:49 +1000 (AEST)
Date: Thu, 16 Apr 2015 15:46:45 -0400 (EDT)
Message-Id: <20150416.154645.1793237575915320132.davem@davemloft.net>
To: sowmini.varadhan@oracle.com
Subject: Re: [PATCH v10 0/3] Generic IOMMU pooled allocator
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1428605063.git.sowmini.varadhan@oracle.com>
References: <cover.1428605063.git.sowmini.varadhan@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu,  9 Apr 2015 15:33:29 -0400

> Investigation of network performance on Sparc shows a high
> degree of locking contention in the IOMMU allocator, and it
> was noticed that the PowerPC code has a better locking model.
> 
> This patch series tries to extract the generic parts of the 
> PowerPC code so that it can be shared across multiple PCI
> devices and architectures.

Series applied, thanks everyone for all the hard work!
