Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE6A61A0163
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 07:20:43 +1000 (AEST)
In-Reply-To: <1440669019-23800-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Ochs <mrochs@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [1/2] cxl: Fix + cleanup error paths in cxl_dev_context_init
Message-Id: <20150830212043.80FFA14016A@ozlabs.org>
Date: Mon, 31 Aug 2015 07:20:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-27-08 at 09:50:18 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> If the cxl_context_alloc() call fails, we return immediately without
> releasing the reference on the AFU device, allowing it to leak.
> 
> This patch switches to using goto style error handling so that the
> device is released in common code for both error paths, and will also
> simplify things if we add additional initialisation in this function in
> the future.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/af2a50bb0ce1ca7a9c478481

cheers
