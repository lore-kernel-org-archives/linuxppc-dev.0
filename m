Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1495DB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 04:47:01 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4428DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 04:47:00 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n89Ikvun025623
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Sep 2009 11:46:57 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n89Ikvoq028828
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Sep 2009 13:46:57 -0500 (CDT)
Date: Wed, 9 Sep 2009 13:46:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] 82xx: kmalloc failure ignored in ep8248e_mdio_probe()
Message-ID: <20090909184656.GD8215@b07421-ec1.am.freescale.net>
References: <4AA7C095.7090009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AA7C095.7090009@gmail.com>
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

On Wed, Sep 09, 2009 at 04:49:57PM +0200, Roel Kluin wrote:
> Prevent NULL dereference if kmalloc() fails. Also clean up if
> of_mdiobus_register() returns an error.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
