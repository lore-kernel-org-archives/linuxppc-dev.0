Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A46E1A0337
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:15:56 +1100 (AEDT)
In-Reply-To: <1447905639-31018-1-git-send-email-k.kozlowski@samsung.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RESEND] powerpc/powernv: Drop owner assignment from
 platform_driver
Message-Id: <20151126121555.AB6F414030F@ozlabs.org>
Date: Thu, 26 Nov 2015 23:15:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-19-11 at 04:00:39 UTC, Krzysztof Kozlowski wrote:
> platform_driver does not need to set an owner because
> platform_driver_register() will set it.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/87630eb1d5ab76fc39e78529

cheers
