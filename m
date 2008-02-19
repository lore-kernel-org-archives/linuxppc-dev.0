Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.245])
	by ozlabs.org (Postfix) with ESMTP id 1469ADDEF8
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 02:12:04 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id x43so1072659hsb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 07:12:02 -0800 (PST)
Message-ID: <fa686aa40802190712n5eef80acq474d5fc8a7b19588@mail.gmail.com>
Date: Tue, 19 Feb 2008 08:12:02 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: EricDuj <eric.dujardin@sagem.com>
Subject: Re: [PATCH] fix 2.6.25-rc2 build with CONFIG_SPI_MPC52xx_PSC
In-Reply-To: <15560565.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <15560565.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 19, 2008 7:50 AM, EricDuj <eric.dujardin@sagem.com> wrote:
>
> Hello again,
>
> Here is a second patch as the link phase fails in the same configuration.
> The error is the following:
>
<snip>
>
> Find the patch below.
> Best,
> Eric


Thanks.  This looks right.  In order to pick up this patch, I need you
to reply with your "Signed-off-by:" line.

Cheers,
g.

>
> ===========================================================================
> --- arch/powerpc/platforms/52xx/mpc52xx_common.c.orig   2008-02-19
> 14:14:52.000000000 +0100
> +++ arch/powerpc/platforms/52xx/mpc52xx_common.c        2008-02-19
> 14:12:56.000000000 +0100
> @@ -199,6 +199,7 @@
>
>         return 0;
>  }
> +EXPORT_SYMBOL(mpc52xx_set_psc_clkdiv);
>
>  /**
>   * mpc52xx_restart: ppc_md->restart hook for mpc5200 using the watchdog
> timer
> ========================================================================
>
>
> --
> View this message in context: http://www.nabble.com/-PATCH--fix-2.6.25-rc2-compilation-with-CONFIG_SPI_MPC52xx_PSC-tp15560559p15560565.html
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
