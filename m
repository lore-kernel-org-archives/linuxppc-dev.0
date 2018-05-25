Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqR5dCDzF1lS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:39 +1000 (AEST)
In-Reply-To: <20180423193638.10535-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/mm/radix: use do/while(0) trick for single statement
 block
Message-Id: <40skqR2pvmz9s4V@ozlabs.org>
Date: Fri, 25 May 2018 21:41:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-23 at 19:36:38 UTC, Mathieu Malaterre wrote:
> In commit 7a22d6321c3d ("powerpc/mm/radix: Update command line parsing for
> disable_radix") an `if` statement was added for a possible empty body
> (prom_debug).
> 
> Fix the following warning, treated as error with W=1:
> 
>   arch/powerpc/kernel/prom_init.c:656:46: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/85aa4b98419d74dd5cc914e0893498

cheers
