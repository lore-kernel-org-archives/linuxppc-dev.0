Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BACBB7CC2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 04:05:12 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0KH59oe010769
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 10:05:09 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o0KHAZM8010019
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 11:10:35 -0600 (CST)
Message-ID: <4B573732.3030000@freescale.com>
Date: Wed, 20 Jan 2010 11:02:42 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 01/11] fs_enet: Add support for MPC512x to fs_enet driver
References: <1263932653-3634-1-git-send-email-agust@denx.de>	<1263932653-3634-2-git-send-email-agust@denx.de>	<4B561AA3.7040506@freescale.com>
	<20100120122058.1539412b@wker>
In-Reply-To: <20100120122058.1539412b@wker>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Piotr Ziecik <kosmo@semihalf.com>, dzu@denx.de, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anatolij Gustschin wrote:
> Scott Wood <scottwood@freescale.com> wrote:
>> You can put a data pointer in the of_platform match struct, instead of 
>> re-checking the compatible.
> 
> .data pointer in 'fs_enet_mdio_fec_match' is already used for
> mpc5xxx_get_bus_frequency(). Setting .data to some sort of FEC ID in
> match struct for "fsl,pq1-fec-mdio" would be confusing to.

You could point .data to a struct if there are multiple things.

-Scott
