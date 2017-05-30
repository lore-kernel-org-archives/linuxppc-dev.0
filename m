Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSXK12zSzDqCv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:11:29 +1000 (AEST)
In-Reply-To: <20170526161946.7bf423c4@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: powerpc: use the asm-genric versions of some uapi includes
Message-Id: <3wcSXJ69JDz9s7t@ozlabs.org>
Date: Tue, 30 May 2017 19:11:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-26 at 06:19:46 UTC, Stephen Rothwell wrote:
> These are completely obvious as all they do is include the asm-generic
> versions.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b87901e6ec782b881224e1723eb142

cheers
