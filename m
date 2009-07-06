Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2AC26B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 02:23:44 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D5F2DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 02:23:42 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n66GNLso027531
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Jul 2009 09:23:32 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n66GNLqi028701
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Jul 2009 11:23:21 -0500 (CDT)
Date: Mon, 6 Jul 2009 11:23:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Aaron Pace <kodiakuppercut@gmail.com>
Subject: Re: Non-contiguous physical memory on 8572
Message-ID: <20090706162321.GB1962@b07421-ec1.am.freescale.net>
References: <bc81dc640907021311y1395ed15l2d50cebb3749c29f@mail.gmail.com>
	<4A4D2332.1060607@freescale.com>
	<bc81dc640907021456v2e7750cer5732d5c84953801a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc81dc640907021456v2e7750cer5732d5c84953801a@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 02, 2009 at 03:56:39PM -0600, Aaron Pace wrote:
> Secondly, can you elaborate on how/when the reserved area could be
> mapped into the TLB?  I don't by any means lay claim to a complete
> understanding of this area, but aside from a direct ioremap/mmap call,
> how would this area get mapped at all?

Linux maps low memory (up to 768MiB) regardless of reserved regions --
the assumption is that it can't be clobbered, not that it isn't RAM.

-Scott
