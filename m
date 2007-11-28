Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7C0C0DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 09:30:08 +1100 (EST)
Message-ID: <474DEB78.6010209@am.sony.com>
Date: Wed, 28 Nov 2007 14:28:08 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 4/7] ps3: Add repository polling loop to work
	around	hypervisor bug
References: <20071128143142.580732000@pademelon.sonytel.be>
	<20071128143438.407055000@pademelon.sonytel.be>
In-Reply-To: <20071128143438.407055000@pademelon.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:

> ps3: Add repository polling loop to work around hypervisor bug
> 
> On some firmware versions (e.g. 1.90), the storage device may not show up
> in the repository immediately after receiving the notification message.
> Add a small polling loop to make sure we don't miss it.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/platforms/ps3/device-init.c |   47 ++++++++++++++++++++++---------
>  1 files changed, 34 insertions(+), 13 deletions(-)

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
