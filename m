Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0132.outbound.protection.outlook.com [157.56.111.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D97E21A0D31
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 13:00:48 +1100 (AEDT)
Date: Thu, 29 Jan 2015 20:00:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Subject: Re: [v3,1/2] powerpc/corenet: Enable muxing MDIO buses via GPIO
Message-ID: <20150130020031.GA21556@home.buserror.net>
References: <1421923718-21352-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1421923718-21352-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: kanetkar.shruti@gmail.com, Andy Fleming <afleming@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Shruti Kanetkar <Shruti@Freescale.com>,
 Shaohui Xie <Shaohui.Xie@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 22, 2015 at 04:48:37AM -0600, Emil Medve wrote:
> From: Andy Fleming <afleming@gmail.com>
> 
> Change-Id: I4489db79957ad533f4ba3f04fe7d5bcb3288e981
> Signed-off-by: Andy Fleming <afleming@gmail.com>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
> ---

scott@snotra:~/fsl/git/linux/upstream$ ./scripts/checkpatch.pl v3-1-2-powerpc-corenet-Enable-muxing-MDIO-buses-via-GPIO.patch 
ERROR: Remove Gerrit Change-Id's before submitting upstream.
#21: 
Change-Id: I4489db79957ad533f4ba3f04fe7d5bcb3288e981

total: 1 errors, 0 warnings, 24 lines checked

v3-1-2-powerpc-corenet-Enable-muxing-MDIO-buses-via-GPIO.patch has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.

-Scott
