Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37C791A0CB0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:27:06 +1000 (AEST)
In-Reply-To: <1438344538.13223.9.camel@tiscali.nl>
To: Paul Bolle <pebolle@tiscali.nl>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: windfarm: decrement client count when unregistering
Message-Id: <20150810092705.E2F121402BF@ozlabs.org>
Date: Mon, 10 Aug 2015 19:27:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-31-07 at 12:08:58 UTC, Paul Bolle wrote:
> wf_unregister_client() increments the client count when a client
> unregisters. That is obviously incorrect. Decrement that client count
> instead.
> 
> Fixes: 75722d3992f5 ("[PATCH] ppc64: Thermal control for SMU based machines")
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fe2b592173ff0274e70d

cheers
