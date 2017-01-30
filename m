Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBnNH0B2tzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 22:34:07 +1100 (AEDT)
In-Reply-To: <1485359673-4474-1-git-send-email-arbab@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: use the correct pointer when setting a 2M pte
Message-Id: <3vBnNG6Q3Sz9sXx@ozlabs.org>
Date: Mon, 30 Jan 2017 22:34:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-01-25 at 15:54:33 UTC, Reza Arbab wrote:
> When setting a 2M pte, radix__map_kernel_page() is using the address
> 
> 	ptep = (pte_t *)pudp;
> 
> Fix this conversion to use pmdp instead. Use pmdp_ptep() to do this
> instead of casting the pointer.
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a0615a16f7d0ceb5804d295203c302

cheers
