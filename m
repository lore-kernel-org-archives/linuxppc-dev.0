Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 8437A2C02CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 03:14:55 +1000 (EST)
Message-ID: <51DEE810.3090304@tabi.org>
Date: Thu, 11 Jul 2013 12:14:56 -0500
From: timur@tabi.org
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Disable SSI in trigger() if RE/TE are both
 cleared
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk>
In-Reply-To: <20130711165401.GU24508@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 11:54 AM, Mark Brown wrote:
>> > The code enabled SSIEN when triggered by SNDRV_PCM_TRIGGER_START,
>> > so move the disable code to SNDRV_PCM_TRIGGER_STOP for symmetric.
> Applied, thanks.

Don't you need an ACK from the maintainer of the driver before applying
it?  I haven't had a chance to test it yet.

-- 
Timur Tabi
