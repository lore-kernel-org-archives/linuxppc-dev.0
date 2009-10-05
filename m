Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F04ABB7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 04:06:16 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n95H6Cjv001041 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 5 Oct 2009 10:06:12 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n95H6C25010332
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 5 Oct 2009 12:06:12 -0500 (CDT)
Date: Mon, 5 Oct 2009 12:06:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grzegorz Jakubowski <grzegorzj@platan.pl>
Subject: Re: problem with PCI network card on MPC8323E but works on MPC8313E
Message-ID: <20091005170611.GA22909@b07421-ec1.am.freescale.net>
References: <4AC99CE4.40600@platan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AC99CE4.40600@platan.pl>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 05, 2009 at 09:14:44AM +0200, Grzegorz Jakubowski wrote:
> maybe problem is with I/O ports (failed instruction was ioread8) because 
>    on one board I/O ports are not assigned, but on MPC8323E they are 
> invalid assigned.
> I have no idea how to solve my problem, thanks for any help. What should 
> I try to do?

Check your U-Boot and device tree, and make sure they agree on PCI
configuration.  If you're running an old U-Boot, upgrade.

-Scott
