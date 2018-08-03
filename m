Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hkL15XlBzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:48:41 +1000 (AEST)
In-Reply-To: <20180802153951.3576-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powernv/cpuidle: Fix idle states all being marked invalid
Message-Id: <41hkL147hGz9s4V@ozlabs.org>
Date: Fri,  3 Aug 2018 20:48:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-02 at 15:39:51 UTC, Nicholas Piggin wrote:
> Commit 9c7b185ab2 ("powernv/cpuidle: Parse dt idle properties into
> global structure") parses dt idle states into structs, but never
> marks them valid. This results in all idle states being lost.
> 
> Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3127692deba6eeb7ed6d416b25e91f

cheers
