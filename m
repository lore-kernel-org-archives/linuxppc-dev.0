Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5829FDDDF5
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 07:40:06 +1100 (EST)
Subject: Re: Revised: [PATCH 5/11] Celleb: htab routines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200702070845.l178jFjK001082@toshiba.co.jp>
References: <200702070845.l178jFjK001082@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 07:39:45 +1100
Message-Id: <1170880786.2620.285.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-07 at 17:45 +0900, Ishizaki Kou wrote:

> +	local_irq_save(flags);
> +	spin_lock(&beat_htab_lock);
> +	dummy1 = beat_lpar_hpte_getword0(slot);
> +

Sorry if I was not very clear... In that specific case, you can use
spin_lock_irqsave(). The above works though, thus the patch can be
merged, and we can do a cleanup patch on top later on to "fix it up"

Ben.
