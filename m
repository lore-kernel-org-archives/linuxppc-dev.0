Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id E3ABCDDEF0
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 20:57:24 +1000 (EST)
Date: Tue, 5 Aug 2008 10:28:27 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 3/3] powerpc - Make the irq reverse mapping radix tree
	lockless
Message-ID: <20080805102827.7d8dbc4b@bull.net>
In-Reply-To: <1217867496.3946.33.camel@localhost.localdomain>
References: <1217848124-3719-1-git-send-email-sebastien.dugue@bull.net>
	<1217848124-3719-4-git-send-email-sebastien.dugue@bull.net>
	<1217867496.3946.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 04 Aug 2008 09:31:36 -0700 Daniel Walker <dwalker@mvista.com> wrote:

> On Mon, 2008-08-04 at 13:08 +0200, Sebastien Dugue wrote:
> 
> > --- a/arch/powerpc/include/asm/irq.h
> > +++ b/arch/powerpc/include/asm/irq.h
> > @@ -119,6 +119,7 @@ struct irq_host {
> >  		} linear;
> >  		struct radix_tree_root tree;
> >  	} revmap_data;
> > +	spinlock_t	       tree_lock;
> 
> You have a tabbing issue above..

  Yuck, right.

  Thanks,

  Sebastien.
