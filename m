Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B475FB6FFC
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 21:30:23 +1000 (EST)
Received: from mail34-va3 (localhost.localdomain [127.0.0.1])	by
	mail34-va3-R.bigfish.com (Postfix) with ESMTP id 1D95C1103DD	for
	<linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 11:30:19 +0000 (UTC)
Received: from VA3EHSMHS036.bigfish.com (unknown [10.7.14.245])	by
	mail34-va3.bigfish.com (Postfix) with ESMTP id DFD4F1628052	for
	<linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 11:30:18 +0000 (UTC)
Subject: Re: powerpc/p1022ds: add missing iounmap calls to platform file
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1307563317-13009-1-git-send-email-timur@freescale.com>
Date: Wed, 22 Jun 2011 06:30:10 -0500
Message-ID: <5FC9ACF8-ADC7-4665-9465-90DD1AE45F5F@freescale.com>
References: <1307563317-13009-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 8, 2011, at 3:01 PM, Timur Tabi wrote:

> The platform file for the Freecale P1022DS reference board is not freeing
> the ioremap() mapping of the PIXIS and global utilities nodes it creates.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/p1022_ds.c |   11 ++++++++---
> 1 files changed, 8 insertions(+), 3 deletions(-)

applied to next

- k
