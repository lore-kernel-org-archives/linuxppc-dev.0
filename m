Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id E381FDDDD5
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 19:43:21 +1000 (EST)
Date: Wed, 11 Jul 2007 11:31:13 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] clock (clk.h) framework for mpc52xx
Message-ID: <20070711093113.GE4375@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <david-b@pacbell.net>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

Clock managing in mpc52xx psc spi driver grew a bit, to do it
"the right way" ;-)

1/3 - Generic powerpc clock interface, platforms that implement
      it should fill clk_functions.
      This is needed because powerpc supports multiple platforms
      in same kernel image.
2/3 - psc spi clocks (mclk) for mpc52xx
3/3 - Use the spi clocks in mpc52xx psc spi driver.


Thanks to David Brownell and Sylvain Munaut for feedback and
help on patches.


	Domen
