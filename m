Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1870ADDE17
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 09:19:05 +1100 (EST)
Message-ID: <474DE952.6000304@am.sony.com>
Date: Wed, 28 Nov 2007 14:18:58 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 2/7] ps3: Add ps3_repository_find_device_by_id()
References: <20071128143142.580732000@pademelon.sonytel.be>
	<20071128143438.201413000@pademelon.sonytel.be>
In-Reply-To: <20071128143438.201413000@pademelon.sonytel.be>
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

> ps3: Add ps3_repository_find_device_by_id()
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/platforms/ps3/platform.h   |    2 
>  arch/powerpc/platforms/ps3/repository.c |   77 ++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)

Looks good.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
