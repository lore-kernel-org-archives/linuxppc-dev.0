Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 9AEC4DDFB0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 May 2008 05:35:21 +1000 (EST)
Date: Sun, 25 May 2008 21:35:12 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Building Cross Compiler for MPC8260ADS
Message-ID: <20080525193512.GC2212@pengutronix.de>
References: <17421912.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <17421912.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 23, 2008 at 02:16:26AM -0700, Misbah khan wrote:
> I need to built the cross compiler for MPC8260ADS to compile it for target
> board. The u-boot which i am using is version 1.1.6. I need to make the
> u-boot configuration and flash the image. I already have a ppc crosscompiler
> but it is giving this error message :-

OSELAS.Toolchain-1.1.1 can build a powerpc-603e-linux-gnu compiler for
you which works for the 8260.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
