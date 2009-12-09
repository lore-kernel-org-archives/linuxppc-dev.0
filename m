Return-Path: <B05799@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0AE76B6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 19:50:15 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB98oBsw011066 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Dec 2009 01:50:12 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nB98tAQl001542
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Dec 2009 02:55:11 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: gianfar breaking builds
Date: Wed, 9 Dec 2009 14:20:01 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81BA08A66@zin33exm22.fsl.freescale.net>
In-Reply-To: <1260341804.16132.22.camel@pasglop>
References: <1260341804.16132.22.camel@pasglop>
From: "Kumar Gopalpet-B05799" <B05799@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Can you point to me from where you cloned the tree.

Also, net-next-2.6 tree was building for me.

--
Thanks
Sandeep

>-----Original Message-----
>From:=20
>linuxppc-dev-bounces+sandeep.kumar=3Dfreescale.com@lists.ozlabs.o
>rg=20
>[mailto:linuxppc-dev-bounces+sandeep.kumar=3Dfreescale.com@lists.
>ozlabs.org] On Behalf Of Benjamin Herrenschmidt
>Sent: Wednesday, December 09, 2009 12:27 PM
>To: Kumar Gala
>Cc: linuxppc-dev
>Subject: gianfar breaking builds
>
>In my next (not pushed out yet as I'm writing this but will be=20
>by the time you read it hopefully), I get a build failure:
>
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c: In=20
>function 'gfar_netpoll':
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2653:=20
>error: invalid storage class for function 'gfar_interrupt'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2652:=20
>warning: ISO C90 forbids mixed declarations and code
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2681:=20
>error: invalid storage class for function 'adjust_link'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2764:=20
>error: invalid storage class for function 'gfar_set_multi'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2855:=20
>error: invalid storage class for function 'gfar_clear_exact_match'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2877:=20
>error: invalid storage class for function 'gfar_set_hash_for_addr'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2898:=20
>error: invalid storage class for function 'gfar_set_mac_for_addr'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:2922:=20
>error: invalid storage class for function 'gfar_error'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3017:=20
>warning: 'alias' attribute ignored
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3032:=20
>error: invalid storage class for function 'gfar_init'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3037:=20
>error: invalid storage class for function 'gfar_exit'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3041:=20
>error: invalid storage class for function '__inittest'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3041:=20
>warning: 'alias' attribute ignored
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042:=20
>error: invalid storage class for function '__exittest'
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042:=20
>warning: ISO C90 forbids mixed declarations and code
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042:=20
>warning: 'alias' attribute ignored
>/home/benh/linux-powerpc-test/drivers/net/gianfar.c:3042:=20
>error: expected declaration or statement at end of input
>make[3]: *** [drivers/net/gianfar.o] Error 1
>
>Stephen says that breakage has been in -next for some time...
>
>Can you guys sort it out ?
>
>Cheers,
>Ben.
>
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
>
