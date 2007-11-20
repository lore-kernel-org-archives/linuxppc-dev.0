Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FD7EDDE2C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 16:54:53 +1100 (EST)
Date: Mon, 19 Nov 2007 23:53:25 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/5] powerpc: document rgmii-rxid and rgmii-txid
	phy-connection-types
In-Reply-To: <20071105121535.c423d095.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0711192353110.1217@blarg.am.freescale.net>
References: <20071105121535.c423d095.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>, jgarzik@pobox.com,
	paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 5 Nov 2007, Kim Phillips wrote:

> A h/w bug requires we program the PHY in RGMII mode for internal delay
> on the receive or transmit side only; document the new property values.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>

applied.

- k
