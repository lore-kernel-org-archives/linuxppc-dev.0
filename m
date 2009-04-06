Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5B5DDDEDF
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 04:26:54 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n36IQpZa015225
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Apr 2009 11:26:51 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n36IQoiW012466
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Apr 2009 13:26:50 -0500 (CDT)
Date: Mon, 6 Apr 2009 13:26:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: Fredrik Arnerup <fredrik.arnerup@edgeware.tv>
Subject: Re: Recap: Kernel oops while duming user core.
Message-ID: <20090406182650.GB4001@ld0162-tx32.am.freescale.net>
References: <1C9CDA9B925A4C77B150D492AFFD022F@edgeware.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1C9CDA9B925A4C77B150D492AFFD022F@edgeware.tv>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 06, 2009 at 05:23:12PM +0200, Fredrik Arnerup wrote:
> Was the kernel oops when dumping core ever resolved?
> (http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051080.html, quoted
> below)
> 
> What was the cause? Is there a patch? A bug tracker ticket?

It was fixed here:
http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051350.html

> Using ELDK here, so still running 2.6.24 ...

Please consider upgrading.

-Scott
