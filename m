Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id BB4D0DDE17
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 18:08:16 +1000 (EST)
Date: Sun, 14 Oct 2007 10:08:13 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: galak@kernel.crashing.org
Subject: [PATCH 0/2] clk for mpc52xx
Message-ID: <20071014080813.GH3000@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello!

Now that the generic part for powerpc went in, it's time to actually
use it.

Split into:
1 - define psc_mclk clocks for mpc52xx
2 - use those clocks in psc_spi driver


	Domen

-- 
Domen Puncer | Research & Development
.............................................................................................
Telargo d.o.o. | Zagrebška cesta 20 | 2000 Maribor | Slovenia
.............................................................................................
www.telargo.com
