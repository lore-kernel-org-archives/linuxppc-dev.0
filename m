Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 39C9F1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Nov 2010 13:37:02 +1100 (EST)
Date: Sun, 28 Nov 2010 18:37:26 -0800 (PST)
Message-Id: <20101128.183726.115930841.davem@davemloft.net>
To: leoli@freescale.com
Subject: Re: [PATCH] ucc_geth: fix ucc halt problem in half duplex mode
From: David Miller <davem@davemloft.net>
In-Reply-To: <1290763798-22844-1-git-send-email-leoli@freescale.com>
References: <1290763798-22844-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, Andreas.Schmitz@riedel.net,
	avorontsov@ru.mvista.com, linuxppc-dev@lists.ozlabs.org,
	jdboyer@media5corp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>
Date: Fri, 26 Nov 2010 17:29:58 +0800

> In commit 58933c64(ucc_geth: Fix the wrong the Rx/Tx FIFO size),
> the UCC_GETH_UTFTT_INIT is set to 512 based on the recommendation
> of the QE Reference Manual.  But that will sometimes cause tx halt
> while working in half duplex mode.
> 
> According to errata draft QE_GENERAL-A003(High Tx Virtual FIFO
> threshold size can cause UCC to halt), setting UTFTT less than
> [(UTFS x (M - 8)/M) - 128] will prevent this from happening
> (M is the minimum buffer size).
> 
> The patch changes UTFTT back to 256.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> Cc: Jean-Denis Boyer <jdboyer@media5corp.com>
> Cc: Andreas Schmitz <Andreas.Schmitz@riedel.net>
> Cc: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied, thank you.
