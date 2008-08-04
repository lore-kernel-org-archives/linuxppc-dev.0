Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 861D4DE2E0
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 02:31:57 +1000 (EST)
Subject: Re: [PATCH 3/3] powerpc - Make the irq reverse mapping radix tree
	lockless
From: Daniel Walker <dwalker@mvista.com>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <1217848124-3719-4-git-send-email-sebastien.dugue@bull.net>
References: <1217848124-3719-1-git-send-email-sebastien.dugue@bull.net>
	<1217848124-3719-4-git-send-email-sebastien.dugue@bull.net>
Content-Type: text/plain
Date: Mon, 04 Aug 2008 09:31:36 -0700
Message-Id: <1217867496.3946.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, linuxppc-dev@ozlabs.org,
	paulus@samba.org, gilles.carry@ext.bull.net, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-04 at 13:08 +0200, Sebastien Dugue wrote:

> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -119,6 +119,7 @@ struct irq_host {
>  		} linear;
>  		struct radix_tree_root tree;
>  	} revmap_data;
> +	spinlock_t	       tree_lock;

You have a tabbing issue above..

Daniel
