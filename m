Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGNH4jkYzDqnq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:51 +1100 (AEDT)
In-Reply-To: <20180124014846.GA27664@embeddedgus>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Michael Hanselmann <linux-kernel@hansmi.ch>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: macintosh/ams-input: Use true and false for boolean values
Message-Id: <3zVGNH1NCkz9t4B@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:51 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-24 at 01:48:46 UTC, "Gustavo A. R. Silva" wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Michael Hanselmann <public@hansmi.ch>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/516c32f64f144721ca05b881737e44

cheers
