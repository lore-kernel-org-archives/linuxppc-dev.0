Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9566ADDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 09:51:17 +1100 (EST)
Message-ID: <474DF057.2060906@am.sony.com>
Date: Wed, 28 Nov 2007 14:48:55 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 6/7] ps3: Refactor ps3_repository_find_device()
References: <20071128143142.580732000@pademelon.sonytel.be>
	<20071128143438.613525000@pademelon.sonytel.be>
In-Reply-To: <20071128143438.613525000@pademelon.sonytel.be>
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

> ps3: Refactor ps3_repository_find_device() to use the existing
> ps3_repository_read_bus_id()
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/platforms/ps3/repository.c |   60 +++++++++++---------------------
>  1 files changed, 22 insertions(+), 38 deletions(-)

Looks good.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
