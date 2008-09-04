Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 7EAF2DE007
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 18:05:09 +1000 (EST)
Date: Thu, 4 Sep 2008 10:04:55 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree
	lockless
Message-ID: <20080904100455.5b96cc29@bull.net>
In-Reply-To: <1220515136.4879.70.camel@pasglop>
References: <1218029429-21114-1-git-send-email-sebastien.dugue@bull.net>
	<1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
	<1219209781.21386.25.camel@pasglop>
	<20080903154105.7dff49db@bull.net>
	<1220496739.4879.20.camel@pasglop>
	<20080904092252.12b3df4a@bull.net>
	<1220513643.4879.68.camel@pasglop>
	<20080904095507.207d1091@bull.net>
	<1220515136.4879.70.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dwalker@mvista.com, tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	jean-pierre.dion@bull.net, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, michael@ellerman.id.au,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 04 Sep 2008 17:58:56 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> >   There's nothing to 'de-initialize' here, or am I missing something?
> > radix_tree_insert() will return ENOMEM and won't insert anything.
> 
> Forget my comment, just fallback.
> 
> > > Or you can fallback if you don't find, as easy, probably
> > > easier since it shouldn't happen in practice.
> > 
> >   That's what I had in mind.
> 
> Thanks for doing that work !
>

  Will do that way.

  Thanks,

  Sebastien.
