Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLm9Q1XV3zDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:08:10 +1100 (AEDT)
In-Reply-To: <1507546364-27628-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: bauerman@linux.vnet.ibm.com
Subject: Re: powerpc/perf/hv-24x7: Fix incorrect comparison in memord
Message-Id: <3yLm9P3sm7z9sNV@ozlabs.org>
Date: Tue, 24 Oct 2017 19:08:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-09 at 10:52:44 UTC, Michael Ellerman wrote:
> In the hv-24x7 code there is a function memord() which tries to
> implement a sort function return -1, 0, 1. However one of the
> conditions is incorrect, such that it can never be true, because we
> will have already returned.
> 
> I don't believe there is a bug in practice though, because the
> comparisons are an optimisation prior to calling memcmp().
> 
> Fix it by swapping the second comparision, so it can be true.
> 
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/05c14c03138532a3cb2aa29c296044

cheers
