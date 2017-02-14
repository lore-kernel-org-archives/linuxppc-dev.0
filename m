Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN27n4lBqzDqy0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:40:21 +1100 (AEDT)
In-Reply-To: <20161209000738.8984-2-david@gibson.dropbear.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCHv2,
 1/4] pseries: Add hypercall wrappers for hash page table resizing
Message-Id: <3vN27n30Btz9s72@ozlabs.org>
Date: Tue, 14 Feb 2017 23:40:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-12-09 at 00:07:35 UTC, David Gibson wrote:
> This adds the hypercall numbers and wrapper functions for the hash page
> table resizing hypercalls.
> 
> It also adds a new firmware feature flag to track the presence of the
> HPT resizing calls.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Paul Mackerras <paulus@samba.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/64b40ffbc83029f035571cad9727e3

cheers
