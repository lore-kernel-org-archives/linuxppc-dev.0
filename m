Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrpBY6BM3zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 18:07:33 +1000 (AEST)
Received: by mail-pa0-x232.google.com with SMTP id r5so34029861pag.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 01:07:33 -0700 (PDT)
Subject: Re: [PATCH V2 44/68] powerpc/mm/radix: Limit paca allocation in radix
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-45-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5719DBBD.70400@gmail.com>
Date: Fri, 22 Apr 2016 18:07:25 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-45-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> On return from rtas we access the paca variables and we have 64 bit
> disabled. This requires us to limit paca in 32 bit range.
> 
> Fix this by setting ppc64_rma_size to first_memblock_size/1G range.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---

Why is this specific to radix?

Balbir Singh.
