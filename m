Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCCB3B7B7A
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 04:20:22 +1000 (EST)
Subject: Re: [PATCH] 82xx: kmalloc failure ignored in ep8248e_mdio_probe()
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <4AA7C095.7090009@gmail.com>
Date: Thu, 24 Sep 2009 11:19:38 -0700
Message-Id: <24C54841-31E8-4999-94F8-7A669BBFD37C@freescale.com>
References: <4AA7C095.7090009@gmail.com>
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 9, 2009, at 7:49 AM, Roel Kluin wrote:

> Prevent NULL dereference if kmalloc() fails. Also clean up if
> of_mdiobus_register() returns an error.
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Found with sed: http://kernelnewbies.org/roelkluin
>
> Please review.

applied to merge

- k
