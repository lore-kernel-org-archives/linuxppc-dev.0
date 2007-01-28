Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id A76DCDDF4D
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 05:35:25 +1100 (EST)
Date: Sun, 28 Jan 2007 19:09:00 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add restart function for mpc52xx
Message-ID: <20070128180900.GL28808@pengutronix.de>
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
	<20070111152137.GG11226@localhost.localdomain>
	<17831.627.162751.166002@cargo.ozlabs.ibm.com>
	<20070112084612.GJ11226@localhost.localdomain>
	<45A74E2F.2000901@246tNt.com>
	<20070112104211.GQ11226@localhost.localdomain>
	<64469e5c846c386f30ae618752697ed6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <64469e5c846c386f30ae618752697ed6@kernel.crashing.org>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2007 at 01:27:14PM +0100, Segher Boessenkool wrote:
> It is perfectly possible to create a binding for a single
> device without making any omissions/errors.

Come on, come back to _this_ universe. People make mistakes, there is
even information unavailable when the firmware is delivered, firmwares
are being set in stone and may never be changed any more once an
embedded device has hit the street. For SoC devices, anything that
requires firmware changes to make Linux behave properly is simply plain
crap.

Look how rmk has solved it for ARM - Sascha has already described it.
The code that gets the information "this is an xyz board" knows
_everything_, starting from the CPU type, up to which peripherals are
there. So it simply can spawn the right platform devices, apply bugfixes
to everything a board vendor has never thought of and is even unwilling
to change in the future, because he simply doesn't care.

It's not that ARM is different than today's SoC PowerPC processors. It's
just that the arm-linux people solved the problems you are describing
here years ago.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
