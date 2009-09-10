Return-Path: <timur@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9B525B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 23:01:25 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2DFF4DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 23:01:24 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8AD15mv022323
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 06:01:16 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8AD2XW8005429
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 08:02:34 -0500 (CDT)
Message-ID: <4AA8F880.1000300@freescale.com>
Date: Thu, 10 Sep 2009 08:00:48 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ucc_geth: Rearrange some code to avoid forward
	declarations
References: <20090910020140.GB31083@oksana.dev.rtsoft.ru>
In-Reply-To: <20090910020140.GB31083@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> We'll need ugeth_disable() and ugeth_enable() calls earlier in the
> file, so rearrange some code to avoid forward declarations.
> 
> The patch doesn't contain any functional changes.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Timur Tabi <timur@freescale.com>

I'm generally not qualified to review ucc_geth patches, but I'm in favor of this one.  I hate forward declarations.

-- 
Timur Tabi
Linux kernel developer at Freescale
