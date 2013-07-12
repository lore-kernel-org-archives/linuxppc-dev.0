Return-Path: <B42378@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A14C2C0323
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 13:59:25 +1000 (EST)
Date: Fri, 12 Jul 2013 11:57:33 +0800
From: Nicolin Chen <b42378@freescale.com>
To: <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Message-ID: <20130712035732.GA27823@MrMyself>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <51DEE810.3090304@tabi.org>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 shawn.guo@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Timur,

On Thu, Jul 11, 2013 at 12:14:56PM -0500, timur@tabi.org wrote:
> Don't you need an ACK from the maintainer of the driver before applying
> it?  I haven't had a chance to test it yet.
If I'm not missing some part of branch updating, it looks like Mark hasn't
pushed it to the branch yet.
Please test it for me. Thank you.

Best regards,
Nicolin Chen
