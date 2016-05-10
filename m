Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYd2BgdzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:37 +1000 (AEST)
In-Reply-To: <1462434849-14935-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [v2,1/2] powerpc/mm: define TOP_ZONE as a constant
Message-Id: <3r4CYd1QC5z9t47@ozlabs.org>
Date: Wed, 11 May 2016 07:48:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-05-05 at 07:54:08 UTC, Oliver O'Halloran wrote:
> The zone that contains the top of memory will be either ZONE_NORMAL
> or ZONE_HIGHMEM depending on the kernel config. There are two functions
> that require this information and both of them use an #ifdef to set
> a local variable (top_zone). This is a little silly so lets just make it
> a constant.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Cc: linux-mm@kvack.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d69777dbefd707974aed91918d

cheers
