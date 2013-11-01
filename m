Return-Path: <oskar@scara.com>
Received: from skyrme.org (skyrme.org [193.175.80.135])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 05EA92C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 21:47:48 +1100 (EST)
Received: from p5b306e20.dip0.t-ipconnect.de ([91.48.110.32]
 helo=curry.scara.com)
 by skyrme.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.63) (envelope-from <oskar@scara.com>) id 1VcBnk-00058N-60
 for linuxppc-dev@lists.ozlabs.org; Fri, 01 Nov 2013 10:18:00 +0000
Date: 1 Nov 2013 10:17:50 +0000
Message-ID: <20131101101750.GB16492@curry>
From: "Oskar Schirmer" <oskar@scara.com>
To: "Xiubo Li" <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, timur@tabi.org,
 perex@perex.cz, r65073@freescale.com, LW@KARO-electronics.de,
 linux@arm.linux.org.uk, b42378@freescale.com, grant.likely@linaro.org,
 devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com,
 swarren@wwwdotorg.org, rob.herring@calxeda.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, rob@landley.net,
 r64188@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not that it would improve functionality, but:

On Fri, Nov 01, 2013 at 15:04:53 +0800, Xiubo Li wrote:
[...]
> diff --git a/sound/soc/fsl/fsl-sgtl5000-vf610.c b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> new file mode 100644
> index 0000000..f535b42
> --- /dev/null
> +++ b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> @@ -0,0 +1,208 @@
> +/*
> + * Freeacale ALSA SoC Audio using SGT1500 as codec.
          ^                             ^   ^
     "Freescale"                    "SGTL5000"

regards,
  Oskar
