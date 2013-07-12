Return-Path: <B42378@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D04E2C0335
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 14:24:45 +1000 (EST)
Date: Fri, 12 Jul 2013 12:19:45 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Message-ID: <20130712041944.GA27906@MrMyself>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
 <20130712040930.GB27823@MrMyself> <51DF826C.40208@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <51DF826C.40208@tabi.org>
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

On Thu, Jul 11, 2013 at 11:13:32PM -0500, Timur Tabi wrote:
> Have you tested it on PowerPC?

Not actually. But I think it won't break the work flow since
the SSI modules on two platform should be literally identical.

But if you still have concern with it, you can ask Mark to wait
and test it later. I'm okay with your decision.

Thanks,
Nicolin Chen
