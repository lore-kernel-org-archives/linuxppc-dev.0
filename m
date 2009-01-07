Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id ABF3EDE508
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 02:07:15 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2582139ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 07:07:14 -0800 (PST)
Message-ID: <fa686aa40901070707h6c10186bv6c7953e7a63c9f3f@mail.gmail.com>
Date: Wed, 7 Jan 2009 08:07:14 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 3/5] powerpc: Bootwrapper and serial console support for
	AmigaOne
In-Reply-To: <20090107140334.299940@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090107135457.234150@gmx.net> <20090107140334.299940@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2009 at 7:03 AM, Gerhard Pircher <gerhard_pircher@gmx.net> wrote:
> diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
> index 8b3607c..f2156f0 100644
> --- a/arch/powerpc/boot/serial.c
> +++ b/arch/powerpc/boot/serial.c
> @@ -117,7 +117,8 @@ int serial_console_init(void)
>        if (devp == NULL)
>                goto err_out;
>
> -       if (dt_is_compatible(devp, "ns16550"))
> +       if (dt_is_compatible(devp, "ns16550") ||
> +           dt_is_compatible(devp, "pnpPNP,501"))
>                rc = ns16550_console_init(devp, &serial_cd);

Why not just claim "ns16550" compatibility in the device tree node?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
