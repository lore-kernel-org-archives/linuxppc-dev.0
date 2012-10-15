Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C4392C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2012 03:14:35 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 15/25] powerpc/fsl_msi: add a const qualifier
Date: Mon, 15 Oct 2012 16:14:27 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708101268@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-16-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1343034810-3386-16-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Tabi Timur-B04825 <B04825@freescale.com>,
 Rob Herring <rob.herring@calxeda.com>, Paul Mackerras <paulus@samba.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2012 at 4:13 AM, Uwe Kleine-K=F6nig
<u.kleine-koenig@pengutronix.de> wrote:
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>
>         arch/powerpc/sysdev/fsl_msi.c: In function 'fsl_of_msi_probe':
>         arch/powerpc/sysdev/fsl_msi.c:379:11: error: assignment discards =
'const' qualifier from pointer target type [-Werror]
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Timur Tabi <timur@freescale.com>

--=20
Timur Tabi
Linux kernel developer at Freescale=
