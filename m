Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 36A5E67D13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 02:40:37 +1000 (EST)
Date: Tue, 26 Jul 2005 09:40:35 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Message-ID: <20050726164034.GE2906@gate.ebshome.net>
References: <1122393448.22059.32.camel@rhino.az.mvista.com>
	<1122393818.22059.38.camel@rhino.az.mvista.com>
	<1122393974.10004.41.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1122393974.10004.41.camel@rhino.az.mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 3/3] MTD support for the Bamboo board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 26, 2005 at 09:06:14AM -0700, Wade Farnsworth wrote:
> This adds MTD support for the Bamboo board.
> 
> Signed-off by: Wade Farnsworth <wfarnsworth@mvista.com>

> diff -uprN linux-2.6.12/drivers/mtd/maps/Kconfig.orig linux-2.6.12-440ep/drivers/mtd/maps/Kconfig.orig
> --- linux-2.6.12/drivers/mtd/maps/Kconfig.orig	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.12-440ep/drivers/mtd/maps/Kconfig.orig	2005-07-25 11:31:51.000000000 -0700

This hunk seems to be bogus.

> diff -uprN linux-2.6.12/drivers/mtd/maps/Makefile.orig linux-2.6.12-440ep/drivers/mtd/maps/Makefile.orig
> --- linux-2.6.12/drivers/mtd/maps/Makefile.orig	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.12-440ep/drivers/mtd/maps/Makefile.orig	2005-07-25 11:31:51.000000000 -0700

Ditto.

> diff -uprN linux-2.6.12/drivers/mtd/nand/Kconfig.orig linux-2.6.12-440ep/drivers/mtd/nand/Kconfig.orig
> --- linux-2.6.12/drivers/mtd/nand/Kconfig.orig	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.12-440ep/drivers/mtd/nand/Kconfig.orig	2005-07-25 11:31:51.000000000 -0700

Ditto

-- 
Eugene
