Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7JL4gtnzF0Pn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:30:42 +1100 (AEDT)
In-Reply-To: <20180112022849.30899-5-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [5/5] powerpc: Use the TRAP macro whenever comparing a trap number
Message-Id: <3zM7JK2hB8z9sRm@ozlabs.org>
Date: Thu, 18 Jan 2018 00:30:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-01-12 at 02:28:49 UTC, Benjamin Herrenschmidt wrote:
> Trap numbers can have extra bits at the bottom that need to
> be filtered out. There are a few cases where we don't do that.
> 
> It's possible that we got lucky but better safe than sorry.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2271db20e4b362405bacc0e4095df4

cheers
