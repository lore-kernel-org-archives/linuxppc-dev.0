Return-Path: <B47053@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 221F42C0B6D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 18:53:10 +1100 (EST)
From: Li Xiubo <B47053@freescale.com>
To: Li Xiubo <B47053@freescale.com>, Shawn Guo <r65073@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "lgirdwood@gmail.com"
 <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Subject: [PATCHv1 0/8] ALSA: Add SAI driver and enable SGT15000 codec
Date: Fri, 1 Nov 2013 07:52:57 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828718C5@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>,
 "perex@perex.cz" <perex@perex.cz>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Guangyu Chen <B42378@freescale.com>, "oskar@scara.com" <oskar@scara.com>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Fabio Estevam <r49496@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>, Zhengxiong Jin <R64188@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry, forgot the Subject!

Sent again.


>=20
> Hello,
>=20
> This patch series is mostly Freescale's SAI SoC Digital Audio Interface
> driver implementation. And the implementation is only compatible with
> device tree definition.
>=20
> This patch series is based on linux-next and has been tested on Vybrid
> VF610 Tower board using device tree.
>=20
> Changed in v2:
> - Use default settings for the generic dmaengine PCM driver.
> - Separate receive and transmit setting in most functions, but some
> couldn't for the HW limitation.
> - Drop some not reduntant code.
> - Use devm_snd_soc_register_component() instead of
> snd_soc_register_component().
> - Use devm_snd_soc_register_card() instead of
> devm_snd_soc_register_card().
> - Adjust the code sentences sequence.
> - Make the namespacing consistent.
> - Rename CONFIG_SND_SOC_FSL_SGTL5000 to CONFIG_SND_SOC_FSL_SGTL5000_VF610=
.
> - Drop some meaningless lines.
> - Rename the binding document file.
>=20
> Added in v1:
> - Add SAI SoC Digital Audio Interface driver.
> - Add Freescale SAI ALSA SoC Digital Audio Interface node for VF610.
> - Enables SAI ALSA SoC DAI device for Vybrid VF610 TOWER board.
> - Add device tree bindings for Freescale SAI.
> - Revise the bugs about the sgt15000 codec.
> - Add SGT15000 based audio machine driver.
> - Enable SGT15000 codec based audio driver node for VF610.
> - Add device tree bindings for Freescale VF610 sound.
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
