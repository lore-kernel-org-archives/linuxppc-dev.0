Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqh42GrzF1kw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:52 +1000 (AEST)
In-Reply-To: <20180523114837.6980-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: malat@debian.org
Subject: Re: [1/2] powerpc/xmon: Specify the full format in DUMP() macro
Message-Id: <40skqg5BJkz9s6t@ozlabs.org>
Date: Fri, 25 May 2018 21:41:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-23 at 11:48:36 UTC, Michael Ellerman wrote:
> In dump_one_paca() the DUMP macro unconditionally prepends '#' to the
> printf format specifier. In most cases we're using either 'x' or 'lx'
> etc. and that is OK. But for 'p' and other formats using '#' is
> actually undefined, and once we enable printf() checking for
> xmon_printf() we will get warnings from the compiler.
> 
> So just have each usage specify the full format, that way we can omit
> '#' when it's inappropriate.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/6671683db8540e5766f44a1089549c

cheers
