Return-Path: <guangyu.chen@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43EB3140080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 12:32:21 +1000 (EST)
Date: Tue, 15 Apr 2014 10:26:58 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_sai: Add clock controls for SAI
Message-ID: <20140415022656.GC7197@MrMyself>
References: <cover.1396432924.git.Guangyu.Chen@freescale.com>
 <12898efab7a5907e6ed1c438a486692f59ef9d8b.1396432924.git.Guangyu.Chen@freescale.com>
 <20140414204331.GE25182@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140414204331.GE25182@sirena.org.uk>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net,
 galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 14, 2014 at 09:43:31PM +0100, Mark Brown wrote:
> On Wed, Apr 02, 2014 at 06:10:19PM +0800, Nicolin Chen wrote:
> 
> > -- clock-names : Must include the "sai" entry.
> > +- clock-names : Must include the "bus" for register access and "mclk1" "mclk2"
> > +  "mclk3" for bit clock and frame clock providing.
> 
> This breaks compatibilty with old DTs - it just removes the "sai" name.
> It's OK to deprecate the "sai" clock name but you need to keep support
> for DTs that only specify that, there's no code for that left in the
> driver.

Sir, you've already applied the v6 of this patch last week :)
And I can still find it in topic/fsl-sai.

ca3e35c ASoC: fsl_sai: Add clock controls for SAI

And regarding the old DTs compatibilty, Shawn has already reminded me
in his comments against one of the version. I took his advice and made
the patch compatible with the old 'sai' clock binding within that v6.

Thank you,
Nicolin
