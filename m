Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id C60F9DDEE9
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 21:42:14 +1100 (EST)
Date: Fri, 12 Jan 2007 11:42:11 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] add restart function for mpc52xx
Message-ID: <20070112104211.GQ11226@localhost.localdomain>
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
	<20070111152137.GG11226@localhost.localdomain>
	<17831.627.162751.166002@cargo.ozlabs.ibm.com>
	<20070112084612.GJ11226@localhost.localdomain>
	<45A74E2F.2000901@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45A74E2F.2000901@246tNt.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2007 at 10:00:31AM +0100, Sylvain Munaut wrote:
> 
> I'm not saying the system is perfect but this issue is more related to
> recent
> bindings that the of thing as a whole. That's more the problem with of
> is that
> when you need to define bindings for something that has none, you may not
> anticipate everything ....

No, you can never do that. Lets hope there will never be incompatible
changes in the device tree so that we have to use this device tree for this
kernel version and another one for other kernel versions.

Sascha


-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
