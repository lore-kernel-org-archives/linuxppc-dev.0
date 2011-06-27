Return-Path: <B11780@freescale.com>
Received: from CH1EHSOBE009.bigfish.com (ch1ehsobe004.messaging.microsoft.com
	[216.32.181.184]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25478B6F53
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 23:35:43 +1000 (EST)
Received: from mail115-ch1 (localhost.localdomain [127.0.0.1])	by
	mail115-ch1-R.bigfish.com (Postfix) with ESMTP id F1CD9510101	for
	<linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 13:35:40 +0000 (UTC)
Received: from CH1EHSMHS005.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.247])	by mail115-ch1.bigfish.com (Postfix) with ESMTP id
	CDE4D17C0051	for <linuxppc-dev@ozlabs.org>;
	Mon, 27 Jun 2011 13:35:40 +0000 (UTC)
Subject: Re: [PATCH] powerpc/85xx: enable the framebuffer console for the
	defconfigs
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1308858535-17396-2-git-send-email-timur@freescale.com>
Date: Mon, 27 Jun 2011 08:35:38 -0500
Message-ID: <98369A9C-E6F6-4034-9BCA-5F12C5462078@freescale.com>
References: <1308858535-17396-1-git-send-email-timur@freescale.com>
	<1308858535-17396-2-git-send-email-timur@freescale.com>
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


On Jun 23, 2011, at 2:48 PM, Timur Tabi wrote:

> Enable framebuffer console support by default in the defconfigs for the
> Freescale 85xx-based reference board.  This allows the boot messages to
> be shown on the video display on the P1022DS.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/configs/mpc85xx_defconfig     |    4 ++++
> arch/powerpc/configs/mpc85xx_smp_defconfig |    4 ++++
> 2 files changed, 8 insertions(+), 0 deletions(-)

applied to next

- K
