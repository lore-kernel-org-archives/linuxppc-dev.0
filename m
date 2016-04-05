Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qflzt1xG6zDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 09:53:30 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id r187so2599642pfr.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Apr 2016 16:53:30 -0700 (PDT)
Subject: Re: [PATCH 12/65] powerpc/mm: Use generic version of
 ptep_clear_flush_young
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57044FF3.1050001@gmail.com>
Date: Wed, 6 Apr 2016 09:53:23 +1000
MIME-Version: 1.0
In-Reply-To: <1459067053-10835-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> The radix variant is going to require a flush_tlb_range. With
> flush_tlb_range added, ptep_clear_flush_young is same as the generic
> version. So drop the powerpc specific variant
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
The changelog is same as 11/65.. May be you could merge 11 and 12 or help
understand the difference better.
