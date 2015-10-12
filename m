Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0960B1A03A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:17:21 +1100 (AEDT)
In-Reply-To: <1434092231-4155-1-git-send-email-kda@linux-powerpc.org>
To: Denis Kirjanov <kda@linux-powerpc.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: agp/uninorth: fix a memleak in create_gatt_table
Message-Id: <20151012111720.EBDD2140D8E@ozlabs.org>
Date: Mon, 12 Oct 2015 22:17:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-12-06 at 06:57:11 UTC, Denis Kirjanov wrote:
> Fix the memory leak in create_gatt_table:
> we've lost a kfree on the exit path for the pages array allocated
> in uninorth_create_gatt_table
> 
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5ada62b1070a57562664713b

cheers
