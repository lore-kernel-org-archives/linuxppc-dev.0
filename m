Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id B23A1DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 04:41:30 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-mtd@lists.infradead.org
Subject: mtd-ram: add of-support
Date: Wed, 21 Jan 2009 18:41:23 +0100
Message-Id: <1232559685-2268-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

as we needed an of-mtd-ram driver to support SRAM on the
phyCORE-MPC5200B-IO, I did the following:

Patch 1:
  refactor plat-ram.c to have generic probe and remove
  routines

Patch 2:
  use the new routines for an of-driver

Looking forward to comments. (Sidenote: Converting all these platform
drivers to support of is really tiring, sigh. Isn't there any other
way?)

Kind regards,

   Wolfram
