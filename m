Return-Path: <guangyu.chen@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8AAB8140082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 12:39:18 +1000 (EST)
Date: Tue, 15 Apr 2014 10:33:26 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix incorrect condition check in trigger()
Message-ID: <20140415023325.GE7197@MrMyself>
References: <1397225400-2769-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140414203126.GB25182@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140414203126.GB25182@sirena.org.uk>
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

On Mon, Apr 14, 2014 at 09:31:26PM +0100, Mark Brown wrote:
> On Fri, Apr 11, 2014 at 10:10:00PM +0800, Nicolin Chen wrote:
> 
> > +		/* Check if the opposite FRDE is also disabled */
> > +		if (!(tx ? rcsr & FSL_SAI_CSR_FRDE : tcsr & FSL_SAI_CSR_FRDE)) {
> 
> I've applied this since it's a fix but this is *not* a triumph of
> legibility, the ternery operator is often not helpful.

It looks like I've got a bad habit again. I'll be careful next time.

Thank you for reminding me,
Nicolin
