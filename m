Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com
	[209.85.217.174]) by ozlabs.org (Postfix) with ESMTP id 0FDF1DDFDD
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Mar 2009 13:01:44 +1100 (EST)
Received: by gxk22 with SMTP id 22so6249821gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 19:01:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49BBC757.7090001@computer.org>
References: <49BBC757.7090001@computer.org>
Date: Sat, 14 Mar 2009 20:01:42 -0600
Message-ID: <fa686aa40903141901jc25836dne554e14182e35dfd@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Remove extra semicolon in fsl_soc.c (2nd try)
From: Grant Likely <grant.likely@secretlab.ca>
To: jdaniel@computer.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, afleming@freescale.com, stable@kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 14, 2009 at 9:03 AM, Johns Daniel <jdaniel@computer.org> wrote:
> TSEC/MDIO will not work with older device trees because of a semicolon at
> the end of a macro resulting in an empty for loop body.
>
> This fix only applies to 2.6.28; this code is gone in 2.6.29, according t=
o
> Grant Likely!
>
> Signed-off-by: Johns Daniel <johns.daniel@gmail.com
> <mailto:johns.daniel@gmail.com>>

Your signed-off-by line is odd.  I assume your mailer did this to you.
 But in case Greg picks it up anyway:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --- linux-2.6.28.7/arch/powerpc/sysdev/fsl_soc.c.orig =A0 2009-02-20
> 16:41:27.000000000 -0600
> +++ linux-2.6.28.7/arch/powerpc/sysdev/fsl_soc.c =A0 =A0 =A0 =A02009-03-1=
4
> 09:01:38.994630400 -0500
> @@ -257,7 +257,7 @@ static int __init gfar_mdio_of_init(void
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gfar_mdio_of_init_one(np);
>
> =A0 =A0 =A0 =A0/* try the deprecated version */
> - =A0 =A0 =A0 for_each_compatible_node(np, "mdio", "gianfar");
> + =A0 =A0 =A0 for_each_compatible_node(np, "mdio", "gianfar")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gfar_mdio_of_init_one(np);
>
> =A0 =A0 =A0 =A0return 0;
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
