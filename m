Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPQZV05rjzDw5c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 15:04:34 +1100 (AEDT)
Subject: Re: [V2,10/68] powerpc/mm: Update _PAGE_KERNEL_RO
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <rep.1421449714.geoff@infradead.org> <874m2yiilt.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Geoff Levand <geoff@infradead.org>
Message-ID: <5aa3fbff-70f8-10de-45a7-d32a224be4e9@infradead.org>
Date: Wed, 23 Nov 2016 20:04:31 -0800
MIME-Version: 1.0
In-Reply-To: <874m2yiilt.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

On 11/23/2016 02:41 AM, Aneesh Kumar K.V wrote:
> Can you try this patch ?
>
> commit 43e05fa840330f0f2deae1e8cc2effd5df68079f
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Wed Nov 23 15:23:05 2016 +0530
>
>     powerpc/mm: Kernel RO fixup for cell

I tested your patch with v4.7, v4.8 and v4.9-rc6, and all work OK.

-Geoff
