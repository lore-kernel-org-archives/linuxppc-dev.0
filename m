Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C668367A6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 04:16:55 +1100 (EST)
In-Reply-To: <422EEA20.4050907@varma-el.com>
References: <422EEA20.4050907@varma-el.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <d32d7ad858d3660f9d7fdf33003ca4cc@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 9 Mar 2005 11:16:49 -0600
To: "Andrey Volkov" <avolkov@varma-el.com>
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

Is this for 2.6?  If so, 5200 needs to be moved to using the new driver=20=

model and platform devices.  Take a look at support for MPC85xx or=20
marvell (mv64x60) as examples.

- kumar

On Mar 9, 2005, at 6:20 AM, Andrey Volkov wrote:

> Hi Paul,
>
> Pls. commit this patch, its needed for MPC5200 Can
>
> Regards
>  Andrey Volkov
>
> Signed-off-by: Andrey Volkov <avolkov@varma-el.com>
>  --
>  ChangeSet@1.2159, 2005-03-09 15:05:37+03:00, avolkov@varma-el.com
>  =A0=A0 ocp_ids.h:
>  =A0=A0=A0=A0 New number for onboard CANbus devs.
>
>
>
> =A0 ocp_ids.h |=A0=A0=A0 1 +
>  =A0 1 files changed, 1 insertion(+)
>
>
>
> diff -Nru a/include/asm-ppc/ocp_ids.h b/include/asm-ppc/ocp_ids.h
>  --- a/include/asm-ppc/ocp_ids.h 2005-03-09 15:07:51 +03:00
>  +++ b/include/asm-ppc/ocp_ids.h 2005-03-09 15:07:51 +03:00
>  @@ -62,6 +62,7 @@
>  =A0 #define OCP_FUNC_RGMII=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
0x00D3
>  =A0 #define OCP_FUNC_TAH=A0 =A0=A0=A0=A0=A0=A0=A0 0x00D4
>  =A0 #define OCP_FUNC_SEC2 =A0=A0=A0=A0=A0=A0=A0 0x00D5=A0 /* =
Crypto/Security 2.0 */
>  +#define OCP_FUNC_CAN=A0=A0 =A0=A0=A0=A0=A0=A0=A0 0x00D6=A0 /* CAN =
bus device */
>
> =A0 /* Network 0x0200 - 0x02FF */
>  =A0 #define OCP_FUNC_EMAC =A0=A0=A0=A0=A0=A0=A0 0x0200
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
