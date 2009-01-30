Return-Path: <rsc@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id B3351DE112
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 10:08:41 +1100 (EST)
Date: Sat, 31 Jan 2009 00:08:35 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Mike Timmons <mike_timmons@trimble.com>
Subject: Re: toolchain for building linux-2.6.27.8 or 2.6.28.1  ...
Message-ID: <20090130230835.GH32026@pengutronix.de>
References: <498208E0.7000707@trimble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <498208E0.7000707@trimble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Mike,

On Thu, Jan 29, 2009 at 01:52:00PM -0600, Mike Timmons wrote:
> Questions:
> 1) if I want to cross-compile a kernel later than 2.6.24 to hopefully  
> get better WAN device support (and clearer options for fw loading),  
> which kernel should I try, and which toolchain?

OSELAS.Toolchain-1.99.2 is known to build working kernels for powerpc,
currently tested for 603e (MPC5200B). We have gcc-4.3.2 at the moment.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
