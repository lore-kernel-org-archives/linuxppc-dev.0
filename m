Return-Path: <guangyu.chen@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 73F7D1400C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Apr 2014 21:26:30 +1000 (EST)
Date: Tue, 8 Apr 2014 19:07:40 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix Bit Clock Polarity configurations
Message-ID: <20140408110738.GA10745@MrMyself>
References: <1396595387-4371-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140404100532.GN14763@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140404100532.GN14763@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 04, 2014 at 11:05:32AM +0100, Mark Brown wrote:
> On Fri, Apr 04, 2014 at 03:09:47PM +0800, Nicolin Chen wrote:
> > The BCP bit in TCR4/RCR4 register rules as followings:
> >   0 Bit clock is active high with drive outputs on rising edge
> >     and sample inputs on falling edge.
> >   1 Bit clock is active low with drive outputs on falling edge
> >     and sample inputs on rising edge.
> 
> Applied, thanks.

Sir, I can't find this patch on any of the remote branches: for-next,
topic/fsl-sai and fix/fsl-sai. Where could I find it?

Thank you,
Nicolin
