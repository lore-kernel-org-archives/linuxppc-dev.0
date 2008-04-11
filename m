Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 585EDDE02D
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 01:38:43 +1000 (EST)
Date: Fri, 11 Apr 2008 10:38:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: Flash on LocalBus @ MPC8343
Message-ID: <20080411153849.GB2588@loki.buserror.net>
References: <47FF802B.5020708@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47FF802B.5020708@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 05:13:47PM +0200, Andre Schwarz wrote:
> To me it looks like there's a problem regarding the local bus in general.
>
> Am I missing a "compatible" or anything else ? "reg" or "ranges" ?

Do you have an of_bus_ids[] entry that covers the localbus?

-Scott
