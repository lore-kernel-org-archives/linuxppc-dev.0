Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f175.google.com (mail-gx0-f175.google.com
	[209.85.217.175]) by ozlabs.org (Postfix) with ESMTP id 15A8CDE259
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 03:03:23 +1100 (EST)
Received: by gxk23 with SMTP id 23so45339gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:03:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ba5d9360903110850gbcb0d2y25f8756a19d46cda@mail.gmail.com>
References: <ba5d9360903110850gbcb0d2y25f8756a19d46cda@mail.gmail.com>
Date: Wed, 11 Mar 2009 10:03:22 -0600
Message-ID: <fa686aa40903110903h1077860dt45c1a5aecd2ef42f@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Remove extra semicolon in fsl_soc.c
From: Grant Likely <grant.likely@secretlab.ca>
To: Johns Daniel <johns.daniel@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Greg KH <gregkh@suse.de>, afleming@freescale.com,
	stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 9:50 AM, Johns Daniel <johns.daniel@gmail.com> wrot=
e:
> A semicolon at the end of the macro means that the for loop has an
> empty body, and so TSEC/MDIO will not work with older device trees.
>
> This fix only applies to 2.6.28; apparently, this code is gone for
> 2.6.29, according to Grant Likely!
>
> Signed-off-by: Johns Daniel <johns.daniel@gmail.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Greg:  Andy Flemming should probably confirm this, but I think this
one should be backported to the stable series.

g.

> ---
> --- linux-2.6.28.7/arch/powerpc/sysdev/fsl_soc.c.orig =A0 2009-02-20
> 16:41:27.000000000 -0600
> +++ linux-2.6.28.7/arch/powerpc/sysdev/fsl_soc.c =A0 =A0 =A0 =A02009-03-1=
0
> 15:56:47.000000000 -0500
> @@ -257,7 +257,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gfar_mdio_of_init_one(np);
>
> =A0 =A0 =A0 =A0/* try the deprecated version */
> - =A0 =A0 =A0 for_each_compatible_node(np, "mdio", "gianfar");
> + =A0 =A0 =A0 for_each_compatible_node(np, "mdio", "gianfar")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gfar_mdio_of_init_one(np);
>
> =A0 =A0 =A0 =A0return 0;
> ---
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
