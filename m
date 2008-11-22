Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B85B4DDF0A
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Nov 2008 08:53:09 +1100 (EST)
Subject: Re: [PATCH 20/32] uninorth-agp section mess
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <E1L3wPK-0006Ym-Kq@ZenIV.linux.org.uk>
References: <E1L3wPK-0006Ym-Kq@ZenIV.linux.org.uk>
Content-Type: text/plain
Date: Sun, 23 Nov 2008 08:52:28 +1100
Message-Id: <1227390748.7185.277.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-11-22 at 17:36 +0000, Al Viro wrote:
> 'aperture' is declared devinitdata (the whole word of it) and
> is used from ->fetch_size() which can, AFAICS, be used on
> !HOTPLUG after init time.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/char/agp/uninorth-agp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
> --- a/drivers/char/agp/uninorth-agp.c
> +++ b/drivers/char/agp/uninorth-agp.c
> @@ -27,7 +27,7 @@
>  static int uninorth_rev;
>  static int is_u3;
>  
> -static char __devinitdata *aperture = NULL;
> +static char *aperture = NULL;
>  
>  static int uninorth_fetch_size(void)
>  {
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
