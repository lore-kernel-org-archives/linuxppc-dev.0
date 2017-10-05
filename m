Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y702s5gmnzDr1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:21:41 +1100 (AEDT)
In-Reply-To: <1506080100-5660-2-git-send-email-allen.lkml@gmail.com>
To: Allen Pais <allen.lkml@gmail.com>, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Allen Pais <allen.lkml@gmail.com>
Subject: Re: [1/3] powerpc: oprofile: use setup_timer() helper.
Message-Id: <3y702s3dtbz9t44@ozlabs.org>
Date: Thu,  5 Oct 2017 15:21:41 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-22 at 11:34:58 UTC, Allen Pais wrote:
> Use setup_timer function instead of initializing timer with the
>    function and data fields.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/83ad1e6a1dc049dd04be4564125a7f

cheers
