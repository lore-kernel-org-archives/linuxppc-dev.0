Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 3F91C67A00
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Apr 2006 18:03:08 +1000 (EST)
Date: Mon, 3 Apr 2006 10:03:03 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: White <white@from-b.org>
Subject: Re: mpc5200b and floating point
Message-ID: <20060403080303.GA4737@localhost.localdomain>
References: <20060331133619.GD7738@localhost.localdomain>
	<20060331203634.3818e8af@White64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060331203634.3818e8af@White64>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 31, 2006 at 08:36:34PM +0200, White wrote:
> Am Fri, 31 Mar 2006 15:36:20 +0200 schrieb Sascha Hauer
> <s.hauer@pengutronix.de> :
> 
> Please check your Toolchain.
> Have you build it ?

I have built it with crosstool 0.38

> 
> Do you use glibc or something like uclibc ?

glibc

With -msoft-float everything is working fine, but with softfloat.
Without flags or with -mhard-float my toolchain (which is btw a
gcc-4.0.2, glibc 2.3.6) generates floating point instructions which I
can see in the objdump.
Since this seems more like a toolchain related problem, maybe the
crosstool ml is a better place for this.

Sascha
