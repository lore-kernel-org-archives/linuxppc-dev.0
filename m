Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 150F91A04B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 11:44:25 +1000 (AEST)
In-Reply-To: <1438153805-31828-7-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [7/8] powerpc/xmon: Drop the 'valid' variable completely in
 'dump_segments'
Message-Id: <20150813014424.864F0140664@ozlabs.org>
Date: Thu, 13 Aug 2015 11:44:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-29-07 at 07:10:04 UTC, Anshuman Khandual wrote:
> Value of the 'valid' variable is zero when 'esid' is zero and it does
> not matter when 'esid' is non-zero. The variable 'valid' can be dropped
> from the function 'dump_segments' by checking for validity of 'esid'
> inside the nested code block. This patch does that change.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8218a3031c204b20582b

cheers
