Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4RNq0FK5zDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 16:41:46 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id yl2so2899604pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 23:41:46 -0700 (PDT)
Message-ID: <1462948896.20338.1.camel@gmail.com>
Subject: Re: [PATCH] powerpc/mm/radix: Add missing tlb flush
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 11 May 2016 16:41:36 +1000
In-Reply-To: <1462943938-29341-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1462943938-29341-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-05-11 at 10:48 +0530, Aneesh Kumar K.V wrote:
> This should not have any impact on hash, because hash does tlb
> invalidate with every pte update and we don't implement
> flush_tlb_* functions for hash. With radix we should make an explicit
> call to flush tlb outside pte update.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> +		flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);

Acked-by: Balbir Singh <bsingharora@gmail.com>
