Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1D7FB6EFF
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2012 03:13:04 +1100 (EST)
Message-ID: <4F144C86.5000403@freescale.com>
Date: Mon, 16 Jan 2012 10:12:54 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>, Florian Tobias Schandinat
 <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
References: <19504.1326673788@neuling.org> <4F1370C9.9010400@freescale.com>
 <21913.1326675139@neuling.org> <4F138CBB.1080901@freescale.com>
 <21370.1326683320@neuling.org>
In-Reply-To: <21370.1326683320@neuling.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> From: Michael Neuling <mikey@neuling.org>
> 
> [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
> 
> Fix a compiler errors introduced in:
>   commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
>   Author: Timur Tabi <timur@freescale.com>
>   drivers/video: fsl-diu-fb: merge all allocated data into one block
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
