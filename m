Return-Path: <B11780@freescale.com>
Received: from CH1EHSOBE018.bigfish.com (ch1ehsobe001.messaging.microsoft.com
	[216.32.181.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11514B7445
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 23:35:47 +1000 (EST)
Received: from mail101-ch1 (localhost.localdomain [127.0.0.1])	by
	mail101-ch1-R.bigfish.com (Postfix) with ESMTP id 3FEB6110019A	for
	<linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 13:35:45 +0000 (UTC)
Received: from CH1EHSMHS026.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.246])	by mail101-ch1.bigfish.com (Postfix) with ESMTP id
	21F262004F
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 13:35:44 +0000 (UTC)
Subject: Re: [PATCH] powerpc/85xx: clamp the P1022DS DIU pixel clock to
	allowed values
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1308858535-17396-1-git-send-email-timur@freescale.com>
Date: Mon, 27 Jun 2011 08:35:44 -0500
Message-ID: <37B600B7-F0ED-4546-883B-9EF2655B38F6@freescale.com>
References: <1308858535-17396-1-git-send-email-timur@freescale.com>
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

> To ensure that the DIU pixel clock will not be set to an invalid value,
> clamp the PXCLK divider to the allowed range (2-255).  This also acts as
> a limiter for the pixel clock.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/p1022_ds.c |    7 ++++++-
> 1 files changed, 6 insertions(+), 1 deletions(-)


applied to next

- K
