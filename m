Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D015B67A79
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2005 08:45:06 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20050327123703.GA23113@pegasos>
References: <20050327123703.GA23113@pegasos>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 08:44:47 +1000
Message-Id: <1111963487.5474.12.camel@gaston>
Mime-Version: 1.0
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

On Sun, 2005-03-27 at 14:37 +0200, Sven Luther wrote:
> Hello,
> 
> Find attached a trivial fix for the 32bit power3 and power4 introduced by
> benh's latest round of pmac sleep fixes.
> 
> I am not sure if this is the best way to solve this problem, but it fixes the
> issue.

Bah, fixe plustot dans le code ... ajout un #ifdef CONFIG_ALTIVEC autour
du dssall (enfin, de la section entiere avec le BEGIN/END inclus) pour
le moment, quoi que ici, le mieux est encore de dire a l'asm de pas
moufter. En ce qui concerne pmac_sleep vs. pmac_cache, #ifdef aussi pour
le moment.

Ben.
