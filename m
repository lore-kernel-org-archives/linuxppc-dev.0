Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC608DDEE4
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 05:16:48 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mAAIGcSf008382
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 11:16:44 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mAAIGbQd019339
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 12:16:37 -0600 (CST)
Date: Mon, 10 Nov 2008 12:16:37 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] powerpc/qe: Select QE_USB with USB_GADGET_FSL_QE
Message-ID: <20081110181637.GA17507@ld0162-tx32.am.freescale.net>
References: <20081108175254.GA6444@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081108175254.GA6444@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 08, 2008 at 08:52:54PM +0300, Anton Vorontsov wrote:
> Boards should know when QE_USB is used, so that they can configure USB
> clocks and pins.
> 
> Another option would be to add 'select QE_USB' into USB_GADGET_FSL_QE,
> but selects are evil since they don't support dependencies.

Can anyone explain *why* select ignores dependencies, rather than
recursively enabling the dependencies (and giving an error if it can't,
or if a dependency has an || in it and is unmet)?

-Scott
