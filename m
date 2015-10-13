Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0117.outbound.protection.outlook.com [157.56.110.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 514491A08ED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 11:22:55 +1100 (AEDT)
Message-ID: <1444695749.5185.96.camel@freescale.com>
Subject: Re: [PATCH v3 00/31]  powerpc/mm: Update page table format for
 book3s 64
From: Scott Wood <scottwood@freescale.com>
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 12 Oct 2015 19:22:29 -0500
In-Reply-To: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-13 at 00:09 +0530, Aneesh Kumar K.V wrote:
> Hi All,
> 
> This patch series attempt to update book3s 64 linux page table format to
> make it more flexible. Our current pte format is very restrictive and we
> overload multiple pte bits. This is due to the non-availability of free bits
> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
> series free up pte_t of 11 bits by moving 4K subpage tracking to the
> lower half of PTE page. The pte format is updated such that we have a
> better method for identifying a pte entry at pmd level. This will also 
> enable
> us to implement hugetlb migration(not yet done in this series). 

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
