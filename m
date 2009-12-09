Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B42C3B7CEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 20:26:32 +1100 (EST)
Subject: RE: gianfar breaking builds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gopalpet-B05799 <B05799@freescale.com>
In-Reply-To: <9F4C7D19E8361D4C94921B95BE08B81BA08A66@zin33exm22.fsl.freescale.net>
References: <1260341804.16132.22.camel@pasglop>
	<9F4C7D19E8361D4C94921B95BE08B81BA08A66@zin33exm22.fsl.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 20:26:20 +1100
Message-ID: <1260350780.16132.40.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-09 at 14:20 +0530, Kumar Gopalpet-B05799 wrote:
> Hi Ben,
> 
> Can you point to me from where you cloned the tree.
> 
> Also, net-next-2.6 tree was building for me.

This is powerpc-next which contains the current Linus stuff plus the
pending powerpc stuff. If that's fixed in net-next then we shall wait
for Dave to merge it I suppose.

Cheers,
Ben.

> --
> Thanks
> Sandeep
> 
> >-----Original Message-----
> >From: 
> >linuxppc-dev-bounces+sandeep.kumar=freescale.com@lists.ozlabs.o
> >rg 
> >[mailto:linuxppc-dev-bounces+sandeep.kumar=freescale.com@lists.
> >ozlabs.org] On Behalf Of Benjamin Herrenschmidt
> >Sent: Wednesday, December 09, 2009 12:27 PM
> >To: Kumar Gala
> >Cc: linuxppc-dev
> >Subject: gianfar breaking builds
> >
> >In my next (not pushed out yet as I'm writing this but will be 
> >by the time you read it hopefully), I get a build failure:
> >
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c: In 
> >function 'gfar_netpoll':
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2653: 
> >error: invalid storage class for function 'gfar_interrupt'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2652: 
> >warning: ISO C90 forbids mixed declarations and code
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2681: 
> >error: invalid storage class for function 'adjust_link'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2764: 
> >error: invalid storage class for function 'gfar_set_multi'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2855: 
> >error: invalid storage class for function 'gfar_clear_exact_match'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2877: 
> >error: invalid storage class for function 'gfar_set_hash_for_addr'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2898: 
> >error: invalid storage class for function 'gfar_set_mac_for_addr'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2922: 
> >error: invalid storage class for function 'gfar_error'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3017: 
> >warning: 'alias' attribute ignored
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3032: 
> >error: invalid storage class for function 'gfar_init'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3037: 
> >error: invalid storage class for function 'gfar_exit'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3041: 
> >error: invalid storage class for function '__inittest'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3041: 
> >warning: 'alias' attribute ignored
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042: 
> >error: invalid storage class for function '__exittest'
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042: 
> >warning: ISO C90 forbids mixed declarations and code
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042: 
> >warning: 'alias' attribute ignored
> >/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042: 
> >error: expected declaration or statement at end of input
> >make[3]: *** [drivers/net/gianfar.o] Error 1
> >
> >Stephen says that breakage has been in -next for some time...
> >
> >Can you guys sort it out ?
> >
> >Cheers,
> >Ben.
> >
> >
> >_______________________________________________
> >Linuxppc-dev mailing list
> >Linuxppc-dev@lists.ozlabs.org
> >https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
