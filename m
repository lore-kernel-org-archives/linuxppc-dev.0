Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4h86R1HzDrvG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:11:20 +1000 (AEST)
In-Reply-To: <20180717042430.15395-1-david@gibson.dropbear.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, aneesh.kumar@linux.vnet.ibm.com,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc/hugetlbpage: Rmove unhelpful HUGEPD_*_SHIFT macros
Message-Id: <41Z4h828kfz9s4s@ozlabs.org>
Date: Tue, 24 Jul 2018 01:11:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-07-17 at 04:24:30 UTC, David Gibson wrote:
> The HUGEPD_*_SHIFT macros are always defined to be PGDIR_SHIFT and
> PUD_SHIFT, and have to have those values to work properly.  They once used
> to have different values, but that was really only because they were used
> to mean different things in different contexts.
> 
> 6fa50483 "powerpc/mm/hugetlb: initialize the pagetable cache correctly for
> hugetlb" removed that double meaning, but left the now useless constants.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fdf743c5c51d5b45db4dada3910954

cheers
