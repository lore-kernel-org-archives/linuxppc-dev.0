Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqVsL0BnzzF1Fv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 16:35:18 +1100 (AEDT)
In-Reply-To: <20180222132118.26774-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxram@us.ibm.com, npiggin@gmail.com,
 mauricfo@linux.vnet.ibm.com, oohall@gmail.com, leitao@debian.org
Subject: Re: [1/2] powerpc/pseries: Support firmware disable of RFI flush
Message-Id: <3zqVsJ6gWKz9s1t@ozlabs.org>
Date: Mon, 26 Feb 2018 16:35:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-22 at 13:21:17 UTC, Michael Ellerman wrote:
> Some versions of firmware will have a setting that can be configured
> to disable the RFI flush, add support for it.
> 
> Fixes: 8989d56878a7 ("powerpc/pseries: Query hypervisor for RFI flush settings")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/582605a429e20ae68fd0b041b2e840

cheers
