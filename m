Return-Path: <guangyu.chen@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 31CA51400F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 13:20:44 +1100 (EST)
Date: Wed, 2 Apr 2014 10:18:49 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH bisect 2/2] ASoC: fsl_sai: Separately enable interrupts
 for Tx and Rx streams
Message-ID: <20140402021847.GC27586@MrMyself>
References: <1396322227-482-1-git-send-email-Guangyu.Chen@freescale.com>
 <1396322227-482-3-git-send-email-Guangyu.Chen@freescale.com>
 <20140401120715.GR2269@sirena.org.uk>
 <20140401132156.GB27586@MrMyself>
 <20140401164254.GA2269@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140401164254.GA2269@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 01, 2014 at 05:42:54PM +0100, Mark Brown wrote:
> On Tue, Apr 01, 2014 at 09:21:57PM +0800, Nicolin Chen wrote:
> 
> > Sir, I just rebased my for-next branch again and found that it's missing
> > two applied patches: "ASoC: fsl_sai: Add isr to deal with error flag" and
> > "ASoC: fsl_sai: Improve fsl_sai_isr()", so that's why this PATCH-2 could
> > not be applied against it as it needs the macro that's included in the
> > patch "ASoC: fsl_sai: Add isr to deal with error flag".
> 
> Ah, those dropped out of -next due to the merge window.  I've applied
> your new patch now.

I can find them on the fsl-sai topic now. Thank you.
