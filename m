Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwfDy2vhPzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 00:22:58 +1000 (AEST)
In-Reply-To: <1461621374-14408-1-git-send-email-bauerman@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [v2] ftrace: Match dot symbols when searching functions on ppc64
Message-Id: <3qwfDy0RZ7z9t7M@ozlabs.org>
Date: Fri, 29 Apr 2016 00:22:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-25-04 at 21:56:14 UTC, Thiago Jung Bauermann wrote:
> In the ppc64 big endian ABI, function symbols point to function
> descriptors. The symbols which point to the function entry points
> have a dot in front of the function name. Consequently, when the
> ftrace filter mechanism searches for the symbol corresponding to
> an entry point address, it gets the dot symbol.
...
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7132e2d669bd42c3783327f301

cheers
