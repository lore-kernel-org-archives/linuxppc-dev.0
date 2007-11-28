Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail14-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 927BCDDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 09:16:58 +1100 (EST)
Message-ID: <474DE8CF.80305@am.sony.com>
Date: Wed, 28 Nov 2007 14:16:47 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 1/7] ps3: Make bus_id and dev_id u64
References: <20071128143142.580732000@pademelon.sonytel.be>
	<20071128143438.096659000@pademelon.sonytel.be>
In-Reply-To: <20071128143438.096659000@pademelon.sonytel.be>
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
> ps3: Make bus_id and dev_id u64.
> 
> These IDs are 64-bit in the repository, and the special storage notification
> device has a device ID of ULONG_MAX.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/platforms/ps3/device-init.c |    4 ++--
>  arch/powerpc/platforms/ps3/mm.c          |    8 ++++----
>  arch/powerpc/platforms/ps3/platform.h    |   12 ++++++------
>  arch/powerpc/platforms/ps3/repository.c  |   21 ++++++++-------------
>  arch/powerpc/platforms/ps3/system-bus.c  |   14 +++++++-------
>  drivers/net/ps3_gelic_net.c              |    4 ++--
>  include/asm-powerpc/ps3.h                |    4 ++--
>  7 files changed, 31 insertions(+), 36 deletions(-)
> 

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>

I saw where 0 passed as a pointer was changed to NULL in your
patch [7] ps3: denoise arch/powerpc/platforms/ps3/repository.c,
so this looks good.

-Geoff
