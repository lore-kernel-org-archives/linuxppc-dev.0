Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb9X32xLszDsjP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 19:50:59 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id my20so299621pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 02:50:59 -0700 (PDT)
Date: Fri, 16 Sep 2016 19:50:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/13] powerpc: move set_soft_enabled() and rename
Message-ID: <20160916195049.3e976b2e@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-4-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-4-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:31:53 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Move set_soft_enabled() from powerpc/kernel/irq.c to
> asm/hw_irq.c. and rename it soft_enabled_set().
> THis way paca->soft_enabled updates can be forced.

Could you just tidy up the changelog a little?

You are renaming it I assume because you are going to introduce more
soft_enabled_x() functions, and that the namespace works better as a
prefix than a postfix.

You are moving it so all paca->soft_enabled updates can be done via
these access functions rather than open coded.

Did I get that right?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
