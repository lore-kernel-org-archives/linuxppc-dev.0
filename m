Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1FMt5QZmzDwNW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:01:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pravin Shedge <pravin.shedge4linux@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mingo@kernel.org,
 fweisbec@gmail.com, john.stultz@linaro.org, ivan@de.ibm.com,
 tglx@linutronix.de, mhiramat@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 shailendras@nvidia.com, keescook@chromium.org, anju@linux.vnet.ibm.com,
 mcgrof@kernel.org, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Cc: pravin.shedge4linux@gmail.com
Subject: Re: [PATCH 38/45] arch/powerpc: remove duplicate includes
In-Reply-To: <1513423957-6118-1-git-send-email-pravin.shedge4linux@gmail.com>
References: <1513423957-6118-1-git-send-email-pravin.shedge4linux@gmail.com>
Date: Tue, 19 Dec 2017 22:01:44 +1100
Message-ID: <874lon9e1z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pravin Shedge <pravin.shedge4linux@gmail.com> writes:

> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.
>
> Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
> ---
>  arch/powerpc/kernel/time.c               | 2 --
>  arch/powerpc/lib/code-patching.c         | 1 -
>  arch/powerpc/mm/numa.c                   | 1 -
>  arch/powerpc/platforms/powernv/npu-dma.c | 1 -
>  arch/powerpc/platforms/powernv/opal.c    | 1 -
>  5 files changed, 6 deletions(-)

Do you want me to merge this, or is it going via some other tree?

If the latter:

  Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
