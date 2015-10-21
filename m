Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 539321A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 22:41:46 +1100 (AEDT)
In-Reply-To: <1445277206.30908.6.camel@infradead.org>
To: Geoff Levand <geoff@infradead.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: powerpc: Add run_cmd function to boot wrapper
Message-Id: <20151021114145.F3620140E32@ozlabs.org>
Date: Wed, 21 Oct 2015 22:41:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-19-10 at 17:53:26 UTC, Geoff Levand wrote:
> Add a boot wrapper script function run_cmd which will run a shell command
> quietly and only print the output if either V=1 or an error occurs.
> 
> Also, run the ps3 dd commands with run_cmd to clean up the build output.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/879c26d4f6a2b573d75cc235

cheers
