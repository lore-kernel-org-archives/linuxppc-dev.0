Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id A87152C0361
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:40:35 +1100 (EST)
Message-ID: <526FACC1.7010909@tabi.org>
Date: Tue, 29 Oct 2013 07:40:33 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and disable TIE/RIE
 in trigger()
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org> <20131029115711.GA9605@MrMyself>
 <526FA78D.2090601@tabi.org> <20131029121330.GB9605@MrMyself>
In-Reply-To: <20131029121330.GB9605@MrMyself>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicolin Chen wrote:
> The DMA request might be remaining high if not disabling it.

Might?  Are you just guessing?

> This would
> cause SDMA re-check this request, while it has no BD existing. For the
> other interrupts, if you don't like it, I can drop it. Just modification
> to the driver might not be less complicated.

I'm only talking about this particular patch.
