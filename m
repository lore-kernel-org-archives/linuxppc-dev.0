Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ED4B1A2C9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 06:27:46 +1100 (AEDT)
Date: Sun, 22 Mar 2015 15:27:26 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: Generic IOMMU pooled allocator
Message-ID: <20150322192726.GB19474@oracle.com>
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
 <1426734106.4770.118.camel@kernel.crashing.org>
 <550A5E5D.90907@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <550A5E5D.90907@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, Anton Blanchard <anton@au1.ibm.com>,
 paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Turned out that I was able to iterate over it, and remove
both the ->cookie_to_index and the ->demap indirection from
iommu_tbl_ops.

That leaves only the odd iommu_flushall() hook, I'm trying
to find the history behind that (needed for sun4u platforms,
afaik, and not sure if there are other ways to achieve this).

Just sent out a new patch-set, which should reach all the 
people/lists on this thread.

If it's possible, it would also help to share any preliminary
code-samples with the iommu_table_ops you folks have in mind.

Please take a look at patchv5, and share your thoughts.

--Sowmini
