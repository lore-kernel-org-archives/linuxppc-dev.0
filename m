Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqVsN0wgWzF1F0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 16:35:20 +1100 (AEDT)
In-Reply-To: <20180222132118.26774-2-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxram@us.ibm.com, npiggin@gmail.com,
 mauricfo@linux.vnet.ibm.com, oohall@gmail.com, leitao@debian.org
Subject: Re: [2/2] powerpc/powernv: Support firmware disable of RFI flush
Message-Id: <3zqVsK6QPSz9s2S@ozlabs.org>
Date: Mon, 26 Feb 2018 16:35:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-22 at 13:21:18 UTC, Michael Ellerman wrote:
> Some versions of firmware will have a setting that can be configured
> to disable the RFI flush, add support for it.
> 
> Fixes: 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush settings")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/eb0a2d2620ae431c543963c8c7f08f

cheers
