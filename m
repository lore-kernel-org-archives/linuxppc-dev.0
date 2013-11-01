Return-Path: <shawn.guo@linaro.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ACD3B2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 23:07:06 +1100 (EST)
Date: Fri, 1 Nov 2013 20:07:03 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
Message-ID: <20131101120700.GE10324@S2101-09.ap.freescale.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101102805.GG28401@MrMyself>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131101102805.GG28401@MrMyself>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, timur@tabi.org,
 perex@perex.cz, r65073@freescale.com, LW@KARO-electronics.de,
 linux@arm.linux.org.uk, Xiubo Li <Li.Xiubo@freescale.com>,
 linux-arm-kernel@lists.infradead.org, grant.likely@linaro.org,
 devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com,
 swarren@wwwdotorg.org, rob.herring@calxeda.com, broonie@kernel.org,
 oskar@scara.com, fabio.estevam@freescale.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, rob@landley.net, r64188@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 01, 2013 at 06:28:05PM +0800, Nicolin Chen wrote:
> >  sound/soc/fsl/fsl-sgtl5000-vf610.c | 208 +++++++++++++++++++++++++++++++++++++
> 
> I just doubt if this file naming is appropriate. Even if we might not have
> rigor rule for the file names, according to existing ones, they are all in
> a same pattern: [SoC name]-[codec name].c
> 
> "imx-sgtl5000.c" for example
> 
> I think it would make user less confused about what this file exactly is if
> this machine driver also follow the pattern: vf610-sgtl5000.c
> 
> 
> @Shawn
> 
> What do you think about the file name?

Yeah, it would be better to name the file following the existing the
pattern.

Shawn
