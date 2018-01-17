Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7HZ3nXXzF0XK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:30:02 +1100 (AEDT)
In-Reply-To: <1509958252-18302-2-git-send-email-linuxram@us.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: ebiederm@xmission.com, linuxram@us.ibm.com, mhocko@kernel.org,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [v9,1/8] powerpc: introduce pte_set_hidx() helper
Message-Id: <3zM7HY1RkNz9sR8@ozlabs.org>
Date: Thu, 18 Jan 2018 00:30:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-11-06 at 08:50:45 UTC, Ram Pai wrote:
> Introduce pte_set_hidx().It sets the (H_PAGE_F_SECOND|H_PAGE_F_GIX) bits
> at the appropriate location in the PTE of 4K PTE. For 64K PTE, it sets
> the bits in the second part of the PTE. Though the implementation for
> the former just needs the slot parameter, it does take some additional
> parameters to keep the prototype consistent.
> 
> This function will be handy as we work towards re-arranging the bits in
> the subsequent patches.
> 
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/59aa31fd6f964ac63ac9cb90c8468f

cheers
