Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CD0A1A0935
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:27:03 +1000 (AEST)
In-Reply-To: <1434075997-23216-1-git-send-email-haokexin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: pci: use %pR for printing struct resource
Message-Id: <20150810092703.569C61401C7@ozlabs.org>
Date: Mon, 10 Aug 2015 19:27:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-12-06 at 02:26:37 UTC, Kevin Hao wrote:
> Use %pR to simplify the debug code. This also make the debug info more
> readable.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ae2a84b4074cff81957b

cheers
