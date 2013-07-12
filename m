Return-Path: <timur@tabi.org>
Received: from relay00.pair.com (relay00.pair.com [209.68.5.9])
 by ozlabs.org (Postfix) with SMTP id 1DAD92C0349
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 22:11:39 +1000 (EST)
Message-ID: <51DFF277.7020105@tabi.org>
Date: Fri, 12 Jul 2013 07:11:35 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: Disable SSI in trigger() if RE/TE
 are both cleared
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
 <20130712084328.GW24508@sirena.org.uk>
In-Reply-To: <20130712084328.GW24508@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 Nicolin Chen <b42378@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 shawn.guo@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark Brown wrote:
> Yes, that's why I just went ahead - you'd said recently that you'd be
> out of action for a while and not able to test anything.

Yeah, I'd rather you waited until I at least made sure it compiled.  Is 
there any way you can at least install the Freescale PowerPC SDK and do 
compile tests?  At least that way you won't have to wait for me for every 
little thing.

-- 
Timur Tabi
