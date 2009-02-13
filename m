Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 6CED0DDDE4
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 02:07:18 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so623989yxb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 07:07:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1234533163557-git-send-email-gjb@semihalf.com>
References: <1234533163557-git-send-email-gjb@semihalf.com>
Date: Fri, 13 Feb 2009 08:07:16 -0700
Message-ID: <fa686aa40902130707t3d3fd060ib6e749dc1fdadabb@mail.gmail.com>
Subject: Re: [PATCH] Configure PSC4 and PSC5 as UART.
From: Grant Likely <grant.likely@secretlab.ca>
To: Grzegorz Bernacki <gjb@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grzegorz,

Please rebase this patch on top of Ben Herrenschmidt's -next tree.
This version is making changes to an older version of the
digsy_mtc.dts file.

g.

On Fri, Feb 13, 2009 at 6:52 AM, Grzegorz Bernacki <gjb@semihalf.com> wrote:
> On digsy MTC PSC4 and PSC5 should be configured as UART, not PSC3 and PSC4.
>
> Signed-off-by: Grzegorz Bernacki <gjb@semihalf.com>
> ---
>  arch/powerpc/boot/dts/digsy_mtc.dts |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
> index 9c76c38..ce33c7c 100644
> --- a/arch/powerpc/boot/dts/digsy_mtc.dts
> +++ b/arch/powerpc/boot/dts/digsy_mtc.dts
> @@ -164,21 +164,21 @@
>                        reg = <0x1f00 0x100>;
>                };
>
> -               serial@2400 {           // PSC3
> +               serial@2600 {           // PSC4
>                        device_type = "serial";
>                        compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> -                       cell-index = <2>;
> -                       reg = <0x2400 0x100>;
> -                       interrupts = <2 3 0>;
> +                       cell-index = <3>;
> +                       reg = <0x2600 0x100>;
> +                       interrupts = <2 11 0>;
>                        interrupt-parent = <&mpc5200_pic>;
>                };
>
> -               serial@2600 {           // PSC4
> +               serial@2800 {           // PSC5
>                        device_type = "serial";
>                        compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> -                       cell-index = <3>;
> -                       reg = <0x2600 0x100>;
> -                       interrupts = <2 11 0>;
> +                       cell-index = <5>;
> +                       reg = <0x2800 0x100>;
> +                       interrupts = <2 12 0>;
>                        interrupt-parent = <&mpc5200_pic>;
>                };
>
> --
> 1.6.0.6
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
