Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qflxL0c01zDq6S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 09:51:18 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id 1so2471481pal.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Apr 2016 16:51:18 -0700 (PDT)
Subject: Re: [PATCH 11/65] powerpc/mm: Use generic version of
 pmdp_clear_flush_young
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57044F6E.1040705@gmail.com>
Date: Wed, 6 Apr 2016 09:51:10 +1000
MIME-Version: 1.0
In-Reply-To: <1459067053-10835-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/03/16 19:23, Aneesh Kumar K.V wrote:
> The radix variant is going to require a flush_pmd_tlb_range. With
> flush_pmd_tlb_range added, pmdp_clear_flush_young is same as the generic
> version. So drop the powerpc specific variant
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
Make sense, what happens to the HPTE variant?

Balbir Singh.
