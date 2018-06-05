Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410b7p0dcdzF1my
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 01:19:34 +1000 (AEST)
In-Reply-To: <20180604083338.2661-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/powernv: copy/paste - Mask SO bit in CR
Message-Id: <410b7n49N9z9s55@ozlabs.org>
Date: Wed,  6 Jun 2018 01:19:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-06-04 at 08:33:38 UTC, Michael Ellerman wrote:
> NX can set the 3rd bit in CR register for XER[SO] (Summary overflow)
> which is not related to paste request. The current paste function
> returns failure for a successful request when this bit is set. So mask
> this bit and check the proper return status.
> 
> Fixes: 2392c8c8c045 ("powerpc/powernv/vas: Define copy/paste interfaces")
> Cc: stable@vger.kernel.org # v4.14+
> Signed-off-by: Haren Myneni <haren@us.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/75743649064ec0cf5ddd69f240ef23

cheers
