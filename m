Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Kv4WvhzDqxn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:31 +1000 (AEST)
In-Reply-To: <1467716886-20991-1-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>, mikey@neuling.org,
 imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com
Subject: Re: [v3] cxl: Refine slice error debug messages
Message-Id: <3rp1Kv2Xh6z9t1L@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 11:08:06 UTC, Philippe Bergheaud wrote:
> The PSL Slice Error Register (PSL_SERR_An) reports implementation
> dependent AFU errors, in the form of a bitmap. The PSL_SERR_An
> register content is printed in the form of hex dump debug message.
> 
> This patch decodes the PSL_ERR_An register contents, and prints a
> specific error message for each possible error bit. It also dumps
> the secondary registers AFU_ERR_An and PSL_DSISR_An, that may
> contain extra debug information.
> 
> This patch also removes the large WARN message that used to report
> the cxl slice error interrupt, and replaces it by a short informative
> message, that draws attention to AFU implementation errors.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6e0c50f9e814220ada60497c52

cheers
