Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BE671A0730
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 19:24:00 +1100 (AEDT)
In-Reply-To: <20160220175836.GA14491@decadent.org.uk>
To: Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/mm: Fix HAVE_ARCH_SOFT_DIRTY dependencies
Message-Id: <20160222082400.4B585140C3B@ozlabs.org>
Date: Mon, 22 Feb 2016 19:24:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-20-02 at 17:58:37 UTC, Ben Hutchings wrote:
> Soft dirty bit support was only implemented for 64-bit Book3S, and
> 32-bit configurations currently fail to build.
> 
> Fixes: 7207f43665b8 ("powerpc/mm: Add page soft dirty tracking")
> References: https://buildd.debian.org/status/fetch.php?pkg=linux&arch=powerpc&ver=4.5%7Erc4-1%7Eexp1&stamp=1455791718
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Thanks for the patch Ben.

I merged a similar but not identical patch into my fixes branch last week, and
Linus merged it over the weekend. Let me know if it isn't sufficient for you:

  https://git.kernel.org/torvalds/c/19f97c983071

cheers
