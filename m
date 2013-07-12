Return-Path: <B42378@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 821162C0335
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 14:13:02 +1000 (EST)
Date: Fri, 12 Jul 2013 12:09:31 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Message-ID: <20130712040930.GB27823@MrMyself>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <51DF7F4F.90707@tabi.org>
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

On Thu, Jul 11, 2013 at 11:00:15PM -0500, Timur Tabi wrote:
> I definitely want to.  Unfortunately, I'm literally in the middle of
> moving into a new house, and so everything is packed up.  I won't be
> able to look at it for another week.

Oh, I see. Actually we've been using this patch for quite a while,
it should be okay.
And I still have some patches pending for the fsl_ssi.c, but looks
like it'll be better for me to wait after you settle down.

Hope everything will run smoothly during your house-moving.
