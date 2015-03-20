Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AD5A1A0423
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 15:23:57 +1100 (AEDT)
Message-ID: <1426825436.2581.1.camel@ellerman.id.au>
Subject: Re: [PATCH v3 0/4] powerpc: trivial unused functions cleanup
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arseny Solokha <asolokha@kb.kras.ru>
Date: Fri, 20 Mar 2015 15:23:56 +1100
In-Reply-To: <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
References: <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
 <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-20 at 10:56 +0700, Arseny Solokha wrote:
> This series removes unused functions from powerpc tree that I've been able
> to discover.
> 
> Two machines at hands, e300 and e500 based, boot and run without regressions
> on my workload with this series applied. The removed code seems also been
> rarely touched, so it seems the series is safe at least in general. But I
> can't obviously express any strong point in support of the series, so it's
> completely OK to leave things as is.
> 
> v3: In patch 4/4, do not remove fsl_mpic_primary_get_version() from
>     arch/powerpc/sysdev/mpic.c because the patch by Jia Hongtao
>     ("powerpc/85xx: workaround for chips with MSI hardware errata") makes
>     use of it.

Sorry, too late.

https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/commit/?h=next&id=5e86bfde9cd93f272844c3ff6ac5f93d3666b3e7


The patch that needs it can just add it back.

cheers
