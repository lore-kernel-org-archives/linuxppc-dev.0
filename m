Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RG64Nf4zDr2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:42 +1100 (AEDT)
In-Reply-To: <20180131075445.9292-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Seth Forshee <seth.forshee@canonical.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/epapr: Move register keyword at the beginning of
 declaration
Message-Id: <401RG63QgQz9sVK@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:42 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-31 at 07:54:43 UTC, Mathieu Malaterre wrote:
> Fix warning for all register unsigned long (0,3-12) that appear during W=1
> compilation:
> 
> ./arch/powerpc/include/asm/epapr_hcalls.h:479:2: warning: ‘register’ is not at beginning of declaration [-Wold-style-declaration]
>   unsigned long register r[\d] asm("r[\d]");
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/65e13c202d7826dc3497c32961008d

cheers
