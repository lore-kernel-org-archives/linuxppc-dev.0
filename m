Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id AF991DDDFB
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 17:56:07 +1100 (EST)
Date: Sun, 9 Nov 2008 07:55:57 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: MPC5200B and the CAN interface
Message-ID: <20081109065557.GD9852@pengutronix.de>
References: <390471.16163.qm@web88105.mail.re2.yahoo.com>
	<491586E3.4090709@mlbassoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <491586E3.4090709@mlbassoc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 08, 2008 at 05:32:35AM -0700, Gary Thomas wrote:
> I'm pretty sure this is just the SocketCAN interface.
> 
> You still need a hardware driver (and one which is SocketCAN compatible).
> I don't see such a driver for the MSCAN (the hardware on the MPC5200) in
> the stock 2.6.27 tree.

The drivers for MPC5200B's mscan are still in the SocketCAN repository,
right. The team is working on getting the patches ready for mainline.

rsc
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
