Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C30801A0B9A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 04:36:17 +1100 (AEDT)
Date: Wed, 25 Mar 2015 13:36:01 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v6 0/3] Generic IOMMU pooled allocator
Message-ID: <20150325173601.GA31861@oracle.com>
References: <cover.1427210772.git.sowmini.varadhan@oracle.com>
 <20150324.181617.1094177939652695812.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150324.181617.1094177939652695812.davem@davemloft.net>
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

On (03/24/15 18:16), David Miller wrote:
> Generally this looks fine to me.
> 
> But about patch #2, I see no reason to have multiple iommu_pool_hash
> tables.  Even from a purely sparc perspective, we can always just do
> with just one of them.
> 
> Furthermore, you can even probably move it down into lib/iommu-common.c
> itself.  iommu_tbl_pool_init() can do the one time initialization.

fixed in v7.

Ben, Alexey, do you need more time to review this?

--Sowmini
