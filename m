Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DDFAB70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 17:41:51 +1000 (EST)
In-Reply-To: <20100916070420.95083C7391@messagerie.si.c-s.fr>
References: <20100916070420.95083C7391@messagerie.si.c-s.fr>
Subject: Re: [PATCH] spi_mpc8xxx: fix writing to adress 0
To: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <OFE491C952.64B1BE24-ONC12577A0.0029DACE-C12577A0.002A0993@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 16 Sep 2010 09:39:09 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: christophe leroy <christophe.leroy@c-s.fr>
> To: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely
> <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-
> kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
> Date: 2010/09/16 09:06
> Subject: [PATCH] spi_mpc8xxx: fix writing to adress 0
> Sent by: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
>
> This patch applies to 2.6.34.7 (already included in 2.6.35.4)
> It fixes an issue when sending only or receiving only (mspi->tx-dma was reset
> as when no tx_buf is defined, tx_dma is 0)
>
> Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
