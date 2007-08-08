Return-Path: <benh@kernel.crashing.org>
Subject: Re: Device tree aware EMAC driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20070808031643.GK10345@bakeyournoodle.com>
References: <20070807062231.GB8351@localhost.localdomain>
	<20070808031643.GK10345@bakeyournoodle.com>
Content-Type: text/plain
Date: Wed, 08 Aug 2007 17:33:23 +1000
Message-Id: <1186558403.938.166.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  * c++ style comments

Ouch... I haven't removed them all ? I promise I didn't -add- any :-)

>  * in emac_probe():
> 	+	/* Wait for dependent devices */
> 	+	err = -ENODEV;
> 	+	err = emac_wait_deps(dev);
>     The initialisation to -ENODEV is pointless right?

Leftover from when it was coded differently yes.

>  * s/get_property/of_get_property/g  or you'll make sfr grumpy ;)
>  * In drivers/net/ibm_newemac/Makefile, I think the preferred method is
>    to use ibm_newemac-y rather than ibm_newemac-objs.
> 
> Is there any reason to leave config IBM_NEW_EMAC (and IBM_EMAC) in
> drivers/net/Kconfig ?  It seems to me they'd be nicer to in the
> appropriate drivers/net/*Kconfig.

Probably.

Ben.
