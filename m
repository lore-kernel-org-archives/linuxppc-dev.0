Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5r36W3zF28s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:44 +1000 (AEST)
In-Reply-To: <1522430905-32131-1-git-send-email-mauricfo@linux.vnet.ibm.com>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc: Move default security feature flags
Message-Id: <40Fv5r0JWKz9s4Z@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-30 at 17:28:24 UTC, Mauricio Faria de Oliveira wrote:
> This moves the definition of the default security feature flags
> (i.e., enabled by default) closer to the security feature flags.
> 
> This can be used to restore current flags to the default flags.
> 
> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e7347a86830f38dc3e40c8f7e28c04

cheers
