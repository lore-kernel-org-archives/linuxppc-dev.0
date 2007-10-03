Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by ozlabs.org (Postfix) with ESMTP id B8168DDE37
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:53:02 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so3251415nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 08:52:59 -0700 (PDT)
Message-ID: <fa686aa40710030852q6f88002amafd33fd773833eb5@mail.gmail.com>
Date: Wed, 3 Oct 2007 09:52:53 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH] SPI: Use fsl_spi instead of mpc83xx_spi
In-Reply-To: <87hcl8xkw5.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <87hcl8xkw5.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/3/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> According to booting-without-of.txt, compatible should be "fsl_spi" and
> mode "cpu" or "qe" for the fsl SPI controllers.
>
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
>  arch/powerpc/boot/dts/mpc8313erdb.dts    |    4 ++--
>  arch/powerpc/boot/dts/mpc8349emitx.dts   |    4 ++--
>  arch/powerpc/boot/dts/mpc8349emitxgp.dts |    4 ++--
>  arch/powerpc/boot/dts/mpc834x_mds.dts    |    4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
> index a8eadc8..9e7eba9 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -71,11 +71,11 @@
>
>                 spi@7000 {
>                         device_type = "spi";
> -                       compatible = "mpc83xx_spi";
> +                       compatible = "fsl_spi";

Compatible is a list property; this might be more appropriate:

compatible = "fsl,mpc8313_spi", "fsl_spi";

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
