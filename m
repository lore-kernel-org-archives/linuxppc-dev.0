Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQvGm2bGXzDqnm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:41:52 +1000 (AEST)
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [01/24] powerpc/mm: Move exception_enter/exit to a do_page_fault
 wrapper
Message-Id: <3xQvGm0kQ5z9sR9@ozlabs.org>
Date: Mon,  7 Aug 2017 20:41:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-19 at 04:49:23 UTC, Benjamin Herrenschmidt wrote:
> This will allow simplifying the returns from do_page_fault
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7afad422ac61067473d5f3d20bbd54

cheers
