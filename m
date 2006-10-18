Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7746067BBC
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 23:50:15 +1000 (EST)
Date: Wed, 18 Oct 2006 17:50:08 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] Slight refactor of interrupt mapping for FSL parts
Message-ID: <20061018175008.7c78261c@vitb.ru.mvista.com>
In-Reply-To: <016001c6f16d$44d707b0$1267a8c0@Jocke>
References: <C6870308-059D-40F8-8567-7A11AFAD2AE2@kernel.crashing.org>
	<016001c6f16d$44d707b0$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, 'Jeff Garzik' <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 16 Oct 2006 23:51:43 +0200
"Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> > > -#define PHY_POLL		-1
> > > +#define PHY_POLL		NO_IRQ
> > >  #define PHY_IGNORE_INTERRUPT	-2
> 
> What does PHY_IGNORE_INTERRUPT mean? Can I use that in a dummy PHY
> driver that just pretends that all is well? Got a ethernet port that
Well you can just use fixed phy from the phy abstraction layer, that I've implemented for the likewise aim. 

Hm, I just recalled I have to update it with new names on phy bus... Anyway, I used it with 8349-mitx to deal with vitesse switch. Just need to submit the change to make it work again. 

-- 
Sincerely, 
Vitaly
