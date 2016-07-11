Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpLxp173CzDqwH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 09:33:18 +1000 (AEST)
Date: Tue, 12 Jul 2016 09:33:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/configs: Enable VMX crypto
Message-ID: <20160712093317.0c3ab74e@canb.auug.org.au>
In-Reply-To: <1468279521-9720-1-git-send-email-anton@ozlabs.org>
References: <1468279521-9720-1-git-send-email-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On Tue, 12 Jul 2016 09:25:21 +1000 Anton Blanchard <anton@ozlabs.org> wrote:
>
> From: Anton Blanchard <anton@samba.org>
> 
> We see big improvements with the VMX crypto functions (often 10x or more),
> so enable it as a module.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/configs/powernv_defconfig | 2 ++
>  arch/powerpc/configs/pseries_defconfig | 2 ++
>  2 files changed, 4 insertions(+)

Not in ppc64_defconfig?

-- 
Cheers,
Stephen Rothwell
