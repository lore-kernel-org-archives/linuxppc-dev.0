Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzXMc34CHzDr7w
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 20:10:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Don Zickus <dzickus@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 santosiv@in.ibm.com, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: watchdog false positive warning at CPU unplug
In-Reply-To: <20170630080740.20766-1-npiggin@gmail.com>
References: <20170630080740.20766-1-npiggin@gmail.com>
Date: Fri, 30 Jun 2017 20:10:03 +1000
Message-ID: <87zicppz0k.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> CPU unplug will call stop_wd_on_cpu regardless if the watchdog has
> been configured to be enabled on that CPU. Don't warn in the case
> it's not in our enabled mask, this is a valid case.
>
> Fixes: powerpc-64s-implement-arch-specific-hardlockup-watchdog.patch
> Reported-by: Santosh Sivaraj <santosiv@in.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/watchdog.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
