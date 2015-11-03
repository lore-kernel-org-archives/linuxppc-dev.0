Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DAE51A0931
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 18:36:54 +1100 (AEDT)
Message-ID: <1446536197.22185.61.camel@freescale.com>
Subject: Re: [PATCH 1/2] mpc85xx/lbc: modify suspend/resume entry sequence
From: Scott Wood <scottwood@freescale.com>
To: Dogra Raghav-B46184 <raghav@freescale.com>
CC: Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 3 Nov 2015 01:36:37 -0600
In-Reply-To: <BY2PR0301MB07750650283AD03A00191EDFD22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
References: <1446186299-2921-1-git-send-email-raghav@freescale.com>
 <BY2PR0301MB0775A3A01F8585352ED5EFADD22C0@BY2PR0301MB0775.namprd03.prod.outlook.com>
 <1446505257.22185.43.camel@freescale.com>
 <BY2PR0301MB077529F563722A726BC39804D22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
 <1446529190.22185.51.camel@freescale.com>
 <BY2PR0301MB0775900A89741E58FA3822D9D22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
 <1446531228.22185.60.camel@freescale.com>
 <BY2PR0301MB07750650283AD03A00191EDFD22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-11-03 at 00:33 -0600, Dogra Raghav-B46184 wrote:
> Hi Scott,
> 
> I just checked on patchwork and noticed that the original patch has been 
> modified as somehow my original comment has become part of the patch:
> +     if (!lbc)
> +             goto out;
>  
>       ctrl->saved_regs = kmalloc(sizeof(struct fsl_lbc_regs), GFP_KERNEL);
>       if (!ctrl->saved_regs)
>               return -ENOMEM;
> [Dogra Raghav-B46184] This is the existing upstream code. Are you 
> suggesting to modify the upstream code to take care of individual registers?
>  
>       _memcpy_fromio(ctrl->saved_regs, lbc, sizeof(struct fsl_lbc_regs));
> +
> The patchwork is also showing two links for the patch. Please apply the 
> original patch present at:
> https://patchwork.ozlabs.org/patch/538605/
> 
> I will look into how this happened to avoid such incidents in future.

Your reply looked like a new patch, so Patchwork treated it as such.  If you 
fix your mailer to use proper quote markers (the > at the beginning of each 
line) then this won't happen.

-Scott
