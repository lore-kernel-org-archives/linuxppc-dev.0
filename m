Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9B58E67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 06:24:49 +1100 (EST)
In-Reply-To: <422F4284.1050806@246tNt.com>
References: <422F4284.1050806@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <22bb842e4ff1ada507be76703dda06f9@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 9 Mar 2005 13:24:35 -0600
To: "Sylvain Munaut" <tnt@246tNt.com>
Cc: paulus@samba.org, linuxppc-embedded@ozlabs.org
Subject: Re: RFC/Commit: New ocp id for CANbus devs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain,

Thanks, the i2c driver that you used on the OCP side should work for=20
you on the platform device side as well.  Also, do you plan on using=20
the ppc_sys stuff for this?  Hopefully yes.

- kumar

On Mar 9, 2005, at 12:37 PM, Sylvain Munaut wrote:

> Andrey Volkov wrote:
>
> > Hi Kumar:
>  >
>  >> Is this for 2.6?=A0
> >
>  > Oh sorry, certainly for 2.6 (Sylvain's kernel more precisely).
>  > But since, Sylvain not maintainer of ocp_ids.h, so I send
>  > this patch to Paul (who create it, am I right?).
>  >
>  >> If so, 5200 needs to be moved to using the new driver model and
> >> platform devices.=A0 Take a look at support for MPC85xx or marvell
> >> (mv64x60) as examples.
>  >>
>  >> - kumar
>  >
>  > Kumar, please, more cleanly, what did you want to say? If you told=20=

> about
>  > board_ocp[] in lite5200.c (platform specific). Then yes, I use it,=20=

> but
> > not mpc5200.c
>  >
>  No, what he said is that MPC5200 needs to be moved to use the =
platform
> bus driver model.
>
> I'll post the patch doing just that on Monday along with PCI and =
sparse
> clean-ups. (Unless something goes wrong ...)
>
>
>
> =A0=A0=A0 Sylvain
