Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 990A7DDF7F
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 14:44:27 +1000 (EST)
Date: Mon, 30 Apr 2007 23:45:25 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [5/5] [v2] pasemi: GPIO MDIO of_platform driver
Message-ID: <20070501044525.GA5230@lixom.net>
References: <20070416062634.GB20196@lixom.net>
	<20070416063139.GC20319@lixom.net>
	<20070418063954.GB11480@lixom.net>
	<17974.50094.70055.169529@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17974.50094.70055.169529@cargo.ozlabs.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 01, 2007 at 02:35:58PM +1000, Paul Mackerras wrote:
> I just noticed this in arch/powerpc/platforms/pasemi/setup.c:
>
> Oof.  Please make sure you only call of_platform_bus_probe if you are
> actually on a pasemi platform... :)

Check your inbox. :-)   Benh just pinged me about it on IRC as well.


-Olof
