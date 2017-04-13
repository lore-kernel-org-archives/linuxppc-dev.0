Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3x1G5rrNzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 08:54:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, benh@kernel.crashing.org
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 01/11] powerpc: move set_soft_enabled() and rename
In-Reply-To: <1491984040-28801-2-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491984040-28801-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491984040-28801-2-git-send-email-maddy@linux.vnet.ibm.com>
Date: Fri, 14 Apr 2017 08:54:06 +1000
Message-ID: <871ssv9awh.fsf@concordia.ellerman.id.au>
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

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
> @@ -269,7 +263,7 @@ notrace void arch_local_irq_restore(unsigned long en)
>  	replay = __check_irq_replay();
>  
>  	/* We can soft-enable now */
> -	set_soft_enabled(IRQ_DISABLE_MASK_NONE);
> +	soft_enabled_set(IRQ_DISABLE_MASK_NONE);

In upstream we don't have any of the IRQ_DISABLE_MASK_* flags.

So something's gotten a bit messed up here, did you forget to send a
patch, or are they out of order or something?

I spent 10 minutes with quilt trying to massage it but pretty much every
patch seems to be patching code that I don't have.

cheers
