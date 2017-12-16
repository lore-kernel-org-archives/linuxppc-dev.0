Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzF6f3yRXzDsPs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 15:43:20 +1100 (AEDT)
Subject: Re: [PATCH v3 03/11] ASoC: fsl_ssi: Refine all comments
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <aad404d3-fa61-3c49-6265-04fc3b256bc6@tabi.org>
Date: Fri, 15 Dec 2017 22:43:14 -0600
MIME-Version: 1.0
In-Reply-To: <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/13/17 5:18 PM, Nicolin Chen wrote:
> -	 * We are running on a SoC which does not support online SSI
> -	 * reconfiguration, so we have to enable all necessary flags at once
> -	 * even if we do not use them later (capture and playback configuration)
> +	 * Online configuration is not supported
> +	 * Enable or Disable all necessary bits at once

This is an example of a bad change, IMHO.  The original was written in 
elegant prose.  The new version is just two short sentences.
