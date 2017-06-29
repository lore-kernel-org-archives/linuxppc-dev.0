Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKB4c07zDr27
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:02 +1000 (AEST)
In-Reply-To: <20170406141450.16060-2-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [2/3] powerpc/mm: Add comments to the vmemmap layout
Message-Id: <3wyzKB42NHz9s65@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-06 at 14:14:49 UTC, Anshuman Khandual wrote:
> Add some explaination to the layout of vmemmap virtual address
> space and how physical page mapping is only used for valid PFNs
> present at any point on the system.
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b0f36c10de8d9bd271ae261604d4e4

cheers
