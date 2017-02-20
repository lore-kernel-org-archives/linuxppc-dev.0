Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRTnK08SqzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 14:36:20 +1100 (AEDT)
Message-ID: <1487561746.23576.170.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm/hugetlb: Filter out hugepage size not
 supported by page table layout
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 20 Feb 2017 14:35:46 +1100
In-Reply-To: <fdc5f84d-f337-24e6-e116-e34cf6ff722b@linux.vnet.ibm.com>
References: <1487499527-16166-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487538354.23576.158.camel@kernel.crashing.org>
 <fdc5f84d-f337-24e6-e116-e34cf6ff722b@linux.vnet.ibm.com>
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

On Mon, 2017-02-20 at 09:02 +0530, Aneesh Kumar K.V wrote:
> To avoid crashes like the one reported in the commit message due to 
> buggy firmware ? 

I don't want Linux to make those assumptions. We should fix the FW.

Think of backward compat for example.

> Also
> It can serve as an easy way to understand what hugepage sizes are 
> supported by different platforms.
> I am yet to figure out what the FSL_BOOK3E and PPC_8xx #ifdef above
> that 
> hunk is all about. Having
> the supported hugepage size clearly verified against makes it easy ?
> 
> -aneesh
