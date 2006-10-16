Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 2EC3067C83
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 07:53:55 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Kumar Gala'" <galak@kernel.crashing.org>,
	"'Andy Fleming'" <afleming@freescale.com>
Subject: RE: [PATCH] Slight refactor of interrupt mapping for FSL parts
Date: Mon, 16 Oct 2006 23:51:43 +0200
Message-ID: <016001c6f16d$44d707b0$1267a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <C6870308-059D-40F8-8567-7A11AFAD2AE2@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, 'Jeff Garzik' <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > -#define PHY_POLL		-1
> > +#define PHY_POLL		NO_IRQ
> >  #define PHY_IGNORE_INTERRUPT	-2

What does PHY_IGNORE_INTERRUPT mean? Can I use that in a dummy PHY
driver that just pretends that all is well? Got a ethernet port that
is connect to a switch directly over MII.
How do I express -2 in a dts file?

 Jocke
