Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4h74hLKzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:11:19 +1000 (AEST)
In-Reply-To: <22eb2f31-3b79-3702-071c-d0fe06a50150@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: chrp/nvram.c: add MODULE_LICENSE()
Message-Id: <41Z4h71QVYz9s3N@ozlabs.org>
Date: Tue, 24 Jul 2018 01:11:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-07-14 at 04:27:48 UTC, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Add MODULE_LICENSE() to the chrp nvram.c driver to fix the build
> warning message:
> 
> WARNING: modpost: missing MODULE_LICENSE() in arch/powerpc/platforms/chrp/nvram.o
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a8bf9e504a6a2bb058b4f020d4ccc5

cheers
