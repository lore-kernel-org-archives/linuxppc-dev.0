Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D1F60DDF1A
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 13:00:24 +1100 (EST)
Message-ID: <4760922C.2060908@am.sony.com>
Date: Wed, 12 Dec 2007 18:00:12 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: akpm@linux-foundation.org
Subject: Re: [PATCH 1/3] ps3: vuart: fix error path locking
References: <20071213003028.676998182@mvista.com>
In-Reply-To: <20071213003028.676998182@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Walker <dwalker@mvista.com>, matthias.kaehlcke@gmail.com,
	linux-kernel@vger.kernel.org, linux@bohmer.net,
	linuxppc-dev@ozlabs.org, mingo@elte.hu, kjwinchester@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This stray down would cause a permanent sleep which doesn't seem correct. 
> The other uses of this semaphore appear fairly mutex like it's even initialized
> with init_MUTEX() ..  So here a patch for removing this one down().
> 
> Signed-off-by: Daniel Walker <dwalker@mvista.com>
> 
> ---
>  drivers/ps3/ps3-vuart.c |    1 -
>  1 file changed, 1 deletion(-)


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Looks, good. 
Andrew, Please apply.

-Geoff 
