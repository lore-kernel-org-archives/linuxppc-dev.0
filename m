Return-Path: <B11780@freescale.com>
Received: from CH1EHSOBE012.bigfish.com (ch1ehsobe001.messaging.microsoft.com
	[216.32.181.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DAEB6B6FB1
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 23:35:43 +1000 (EST)
Received: from mail215-ch1 (localhost.localdomain [127.0.0.1])	by
	mail215-ch1-R.bigfish.com (Postfix) with ESMTP id AC9474B8109	for
	<linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 13:35:40 +0000 (UTC)
Received: from CH1EHSMHS005.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.254])	by mail215-ch1.bigfish.com (Postfix) with ESMTP id
	871F62B804B	for <linuxppc-dev@ozlabs.org>;
	Mon, 27 Jun 2011 13:35:40 +0000 (UTC)
Subject: Re: [PATCH 1/2] powerpc/86xx: enable the framebuffer console on the
	MPC8610 HPCD
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1308845808-11392-1-git-send-email-timur@freescale.com>
Date: Mon, 27 Jun 2011 08:35:29 -0500
Message-ID: <E5A3BF73-179E-4E43-9346-9BE92635D57C@freescale.com>
References: <1308845808-11392-1-git-send-email-timur@freescale.com>
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


On Jun 23, 2011, at 11:16 AM, Timur Tabi wrote:

> Enable framebuffer console support by default in the defconfig on the
> Freescale MPC8610 HPCD reference board.  This allows the boot messages to
> be shown on the video display.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)

applied to next

- K
