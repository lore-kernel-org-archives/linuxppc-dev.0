Return-Path: <gustavo.padovan@collabora.co.uk>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR2qf4xSTzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 09:20:46 +1100 (AEDT)
Date: Thu, 17 Mar 2016 19:11:53 -0300
From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: rename to_user_ptr to __to_user_ptr
Message-ID: <20160317221153.GB2619@joana>
References: <1458245903-3937-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458245903-3937-1-git-send-email-gustavo@padovan.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

2016-03-17 Gustavo Padovan <gustavo@padovan.org>:

> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> to_user_ptr() is a local macro defined by signal_32.c, rename it to
> __to_user_ptr() as now we will have a global to_user_ptr() defined by
> kernel.h that has a different meaning from this one.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  arch/powerpc/kernel/signal_32.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

We changed our mind about the names, so ignore this patch. Sorry for the
noise.

	Gustavo
