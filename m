Return-Path: <srs0=lqgv=5n=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjz4X1rXwzDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 18:25:00 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wjz4X1D7Fz8snT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 18:25:00 +1000 (AEST)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wjz4W47wVz9s7t
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2017 18:24:59 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id v18so3873328pgb.3
 for <linuxppc-dev@ozlabs.org>; Thu, 08 Jun 2017 01:24:59 -0700 (PDT)
Date: Thu, 8 Jun 2017 18:24:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/book3s64: Move PPC_DT_CPU_FTRs and enable it by
 default
Message-ID: <20170608182448.6ab0c1d3@roar.ozlabs.ibm.com>
In-Reply-To: <1496904701-29372-1-git-send-email-mpe@ellerman.id.au>
References: <1496904701-29372-1-git-send-email-mpe@ellerman.id.au>
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

On Thu,  8 Jun 2017 16:51:41 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> The PPC_DT_CPU_FTRs is a bit misplaced in menuconfig, it shows up with
> other general kernel options. It's really more at home in the "Platform
> Support" section, so move it there.
> 
> Also enable it by default, for Book3s 64. It does mostly nothing unless
> the device tree properties are found, and we will want it enabled
> eventually in distro kernels, so turn it on to start getting more
> testing.
> 
> Fixes: 5a61ef74f269 ("powerpc/64s: Support new device tree binding for discovering CPU features")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Well I'd better send the patch to enable it in firmware then.

Thanks,
Nick
