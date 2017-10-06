Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7n3c33hWzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 22:10:04 +1100 (AEDT)
In-Reply-To: <20170907050551.4632-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, bharata@linux.vnet.ibm.com, arbab@linux.vnet.ibm.com,
 npiggin@gmail.com, mikey@neuling.org, cyrilbur@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/powernv: Increase memory block size to 1GB on radix
Message-Id: <3y7n3c2442z9t4b@ozlabs.org>
Date: Fri,  6 Oct 2017 22:10:04 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-07 at 05:05:51 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> Memory hot unplug on PowerNV radix hosts is broken. Our memory block
> size is 256MB but since we map the linear region with very large pages,
> each pte we tear down maps 1GB.
> 
> A hot unplug of one 256MB memory block results in 768MB of memory
> getting unintentionally unmapped. At this point we are likely to oops.
> 
> Fix this by increasing our memory block size to 1GB on PowerNV radix
> hosts.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/53ecde0b9126ff140abe3aefd7f0ec

cheers
