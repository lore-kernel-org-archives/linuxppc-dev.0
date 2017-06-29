Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKK3n2xzDr4Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:09 +1000 (AEST)
In-Reply-To: <20170614042000.1258-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2,1/3] powerpc/powernv/pci: Reduce spam when dumping PEST
Message-Id: <3wyzKK2P0Lz9s82@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-14 at 04:19:58 UTC, Russell Currey wrote:
> Dumping the PE State Tables (PEST) can be highly verbose if a number of PEs
> are affected, especially in the case where the whole PHB is frozen and 512
> lines get printed.  Check for duplicates when dumping the PEST to reduce
> useless output.
> 
> For example:
> 
>     PE[0f8] A/B: 9700002600000000 80000080d00000f8
>     PE[0f9] A/B: 8000000000000000 0000000000000000
>     PE[..0fe] A/B: as above
>     PE[0ff] A/B: 8440002b00000000 0000000000000000
> 
> instead of:
> 
>     PE[0f8] A/B: 9700002600000000 80000080d00000f8
>     PE[0f9] A/B: 8000000000000000 0000000000000000
>     PE[0fa] A/B: 8000000000000000 0000000000000000
>     PE[0fb] A/B: 8000000000000000 0000000000000000
>     PE[0fc] A/B: 8000000000000000 0000000000000000
>     PE[0fd] A/B: 8000000000000000 0000000000000000
>     PE[0fe] A/B: 8000000000000000 0000000000000000
>     PE[0ff] A/B: 8440002b00000000 0000000000000000
> 
> and you can imagine how much worse it can get for 512 PEs.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/31bbd45af313c3b1cdaa98e5a2de65

cheers
