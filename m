Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id 0A358680AE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 23:10:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 19 Aug 2005 15:11:09 +0200
Message-ID: <8E342283C2100540AAC5D1030970547774A3D9@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>, "Kumar Gala" <galak@freescale.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: [RFC][PATCH] [1/2] 8xx platform definitions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello!

The last hunk in this patch looks a bit strange to me:

> --- /dev/null
> +++ b/arch/ppc/syslib/mpc8xx_sys.c
>
>   [ ... ]
>
> +		.mask 		=3D 0x00000000,
> +		.value 		=3D 0x00000000,
> +	},
> +};
> @@ -101,6 +105,22 @@ extern unsigned char __res[];
>
> struct pt_regs;
>
> +enum ppc_sys_devices {

Seems a bit inbetween is missing...

Best regards,

  Peter

-----Original Message-----
From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]=20
Sent: Friday, August 19, 2005 2:44 PM
To: Kumar Gala
Cc: linuxppc-embedded list; Schaefer-Hutter, Peter
Subject: [RFC][PATCH] [1/2] 8xx platform definitions

This is preliminary version of 8xx platform definitions. Currently sys=20
section contains only MPC885 and MPC866. Working example of=20
board-specific setup will follow.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

--=20
Sincerely,
Vitaly
