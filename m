Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrnD41xsPzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 17:23:48 +1000 (AEST)
Received: by mail-pa0-x232.google.com with SMTP id r5so33704407pag.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 00:23:48 -0700 (PDT)
Subject: Re: [PATCH V2 40/68] powerpc/mm/radix: Add MMU_FTR_RADIX
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-41-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5719D17C.8020609@gmail.com>
Date: Fri, 22 Apr 2016 17:23:40 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-41-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> We are going to add asm changes in the follow up patches. Add the
> feature bit now so that we can get it all build. We will enable radix
> in the last patch using cpu table.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---

Looks good!

Acked-by: Balbir Singh <bsingharora@gmail.com>
