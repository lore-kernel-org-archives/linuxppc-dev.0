Return-Path: <B05799@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C8F7FB7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 20:32:29 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB99WLQA007418 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Dec 2009 02:32:21 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nB99aTuV022074
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Dec 2009 03:36:30 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: gianfar breaking builds
Date: Wed, 9 Dec 2009 15:02:14 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81BA08A6F@zin33exm22.fsl.freescale.net>
In-Reply-To: <1260350780.16132.40.camel@pasglop>
References: <1260341804.16132.22.camel@pasglop>
	<9F4C7D19E8361D4C94921B95BE08B81BA08A66@zin33exm22.fsl.freescale.net>
	<1260350780.16132.40.camel@pasglop>
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

=20
>
>This is powerpc-next which contains the current Linus stuff=20
>plus the pending powerpc stuff. If that's fixed in net-next=20
>then we shall wait for Dave to merge it I suppose.
>

I din't notice that netpoll wa enabled in your compilation.
This is also not wotking on net-next tree.

Will send out a patch today in some time.


--

Thanks
Sandeep
