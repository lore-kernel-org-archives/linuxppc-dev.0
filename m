Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D39EDDEDD
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 18:04:56 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree
	lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <20080904095507.207d1091@bull.net>
References: <1218029429-21114-1-git-send-email-sebastien.dugue@bull.net>
	<1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
	<1219209781.21386.25.camel@pasglop> <20080903154105.7dff49db@bull.net>
	<1220496739.4879.20.camel@pasglop> <20080904092252.12b3df4a@bull.net>
	<1220513643.4879.68.camel@pasglop> <20080904095507.207d1091@bull.net>
Content-Type: text/plain
Date: Thu, 04 Sep 2008 17:58:56 +1000
Message-Id: <1220515136.4879.70.camel@pasglop>
Mime-Version: 1.0
Cc: dwalker@mvista.com, tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	jean-pierre.dion@bull.net, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, michael@ellerman.id.au,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>   There's nothing to 'de-initialize' here, or am I missing something?
> radix_tree_insert() will return ENOMEM and won't insert anything.

Forget my comment, just fallback.

> > Or you can fallback if you don't find, as easy, probably
> > easier since it shouldn't happen in practice.
> 
>   That's what I had in mind.

Thanks for doing that work !

Cheers,
Ben.
