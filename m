Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F0A78DDEB7
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 10:29:30 +1000 (EST)
Date: Mon, 16 Apr 2007 19:47:38 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [5/5] pasemi: GPIO MDIO of_platform driver
Message-ID: <20070417004738.GA31053@lixom.net>
References: <20070416062634.GB20196@lixom.net>
	<20070416063139.GC20319@lixom.net>
	<200704170107.12709.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704170107.12709.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 17, 2007 at 01:07:12AM +0200, Arnd Bergmann wrote:
> On Monday 16 April 2007, Olof Johansson wrote:
> > +static int __devinit hack_init(void)
> > +{
> > +???????struct platform_device *pdev;
> > +
> > +???????pdev = platform_device_register_simple("gpio-mdio-bitbang", 0, NULL, 0);
> > +
> > +???????return 0;
> > +}
> > +late_initcall(hack_init);
> 
> Why do you need this? The name already suggests that you are aware that this
> should be autoprobed, but it would be good to have a comment explaining
> why you did it this way.

Because I'm an idiot and forgot to take it away before posting. :-)
Thanks, will clean it up.


-Olof
