Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp1.wanadoo.fr (smtp1.wanadoo.fr [193.252.22.30])
	by ozlabs.org (Postfix) with ESMTP id 6E87267A72
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2005 17:19:09 +1000 (EST)
Received: from me-wanadoo.net (unknown [127.0.0.1])
	by mwinf0106.wanadoo.fr (SMTP Server) with ESMTP id 2CAA21C00167
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2005 09:19:06 +0200 (CEST)
Date: Mon, 28 Mar 2005 09:17:50 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050328071750.GA5735@pegasos>
References: <20050327123703.GA23113@pegasos> <1111963487.5474.12.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1111963487.5474.12.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: ppc32 power3/4 pmac_cache.S build breakage fix.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 28, 2005 at 08:44:47AM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2005-03-27 at 14:37 +0200, Sven Luther wrote:
> > Hello,
> > 
> > Find attached a trivial fix for the 32bit power3 and power4 introduced by
> > benh's latest round of pmac sleep fixes.
> > 
> > I am not sure if this is the best way to solve this problem, but it fixes the
> > issue.
> 
> Bah, fixe plustot dans le code ... ajout un #ifdef CONFIG_ALTIVEC autour
> du dssall (enfin, de la section entiere avec le BEGIN/END inclus) pour
> le moment, quoi que ici, le mieux est encore de dire a l'asm de pas
> moufter. En ce qui concerne pmac_sleep vs. pmac_cache, #ifdef aussi pour
> le moment.

Le truc, c'est que l'ensemble du code de pmac_cache, il ne devrait pas etre
compiler si on est pas CONFIG_6xx, car la fonction n'est jamais appelle depuis
pmac_sleep si on est pas CONFIG_6xx.

Je te laisse gerer cela pour upstream ? 

Amicalement,

Sven Luther
