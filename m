Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 89693DE089
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 12:35:55 +1000 (EST)
Date: Mon, 18 May 2009 19:35:49 -0700 (PDT)
Message-Id: <20090518.193549.98339424.davem@davemloft.net>
To: paubert@iram.es
Subject: Re: [PATCH v2] Allow selecting mv643xx_eth on Pegasos again
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090518232113.GA18469@iram.es>
References: <20090518221847.GA17348@iram.es>
	<598D5675D34BE349929AF5EDE9B03E2702C2D459@az33exm24.fsl.freescale.net>
	<20090518232113.GA18469@iram.es>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, pacman@kosh.dhis.org,
	tbm@cyrius.com, buytenh@wantstofly.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 19 May 2009 01:21:13 +0200

> Since PPC_MUTIPLATFORM was removed, it was impossible to select the
> driver for mv643xx_eth on the Pegasos. Fix it and take the opportunity
> to remove the stale MV64360 config option.
> 
> Signed-off-by: Gabriel Paubert <paubert@iram.es>

This patch doesn't even apply to net-next-2.6, please send me
changes relative to that.
