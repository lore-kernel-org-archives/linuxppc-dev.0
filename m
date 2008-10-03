Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 25FFDDE14E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Oct 2008 02:15:01 +1000 (EST)
Date: Fri, 3 Oct 2008 18:14:51 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: ???? <liu_lin02@tsinghua.org.cn>
Subject: Re: Build cross compile tool chain for PPC
Message-ID: <20081003161451.GK9852@pengutronix.de>
References: <422942429.11977@tsinghua.org.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <422942429.11977@tsinghua.org.cn>
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

On Thu, Oct 02, 2008 at 06:13:49PM +0800, ???? wrote:
> I am a newby for ppc embedded linux. When trying to build the cross
> compiling tool chain, I got some error message in making glibc
> (binutils and gcc are successfully built).

Building cross toolchains is a complicated thing; you may want to have a
look at the existing community build tools, like for example
OSELAS.Toolchain:

http://www.pengutronix.de/oselas/toolchain/index_en.html

The latest beta for 2.0 is here:
http://www.pengutronix.de/oselas/toolchain/download/OSELAS.Toolchain-1.99.0.tar.bz2
(gcc-4.3.2, glibc-2.8, binutils-2.18, kernel-headers-2.6.26)

The more stable 1.x series is here:
http://www.pengutronix.de/oselas/toolchain/download/OSELAS.Toolchain-1.1.1.tar.bz2
(gcc-4.1.2, glibc-2.6, binutils-2.16, kernel-headers-2.6.18)

rsc
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
