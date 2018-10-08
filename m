Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3BBC00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 10:25:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C4D20858
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 10:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C4D20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TGhj3g3DzDqBy
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 21:25:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sntech.de
 (client-ip=185.11.138.130; helo=gloria.sntech.de;
 envelope-from=heiko@sntech.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sntech.de
X-Greylist: delayed 2280 seconds by postgrey-1.36 at bilbo;
 Mon, 08 Oct 2018 21:23:33 AEDT
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TGfY1GcTzDqVD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 21:23:33 +1100 (AEDT)
Received: from wd0081.dip.tu-dresden.de ([141.76.108.81] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1g9S6K-0001gw-I2; Mon, 08 Oct 2018 11:45:20 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 28/36] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
Date: Mon, 08 Oct 2018 11:45:19 +0200
Message-ID: <1857752.ZLvpeyYpZr@phil>
In-Reply-To: <20181005165848.3474-29-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-29-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

either I'm misunderstanding that, or something did go a bit wrong during
the conversion, as pointed out below:

Am Freitag, 5. Oktober 2018, 18:58:40 CEST schrieb Rob Herring:
> Convert Rockchip SoC bindings to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/rockchip.txt      | 220 ----------------
>  .../devicetree/bindings/arm/rockchip.yaml     | 242 ++++++++++++++++++
>  2 files changed, 242 insertions(+), 220 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/rockchip.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/rockchip.yaml
> 



> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amarula,vyasa-rk3288
> +              - asus,rk3288-tinker
> +              - radxa,rock2-square
> +              - chipspark,popmetal-rk3288
> +              - netxeon,r89
> +              - firefly,firefly-rk3288
> +              - firefly,firefly-rk3288-beta
> +              - firefly,firefly-rk3288-reload
> +              - mqmaker,miqi
> +              - rockchip,rk3288-fennec
> +          - const: rockchip,rk3288

These are very much distinct boards, so shouldn't they also get
individual entries including their existing description like the phytec
or google boards below?

Similarly why is it an enum for those, while the Google boards get a
const for each compatible string?


Most non-google boards below also lost their description and where lumped
together into combined entries. Was that intentional?


Thanks
Heiko

> +
> +      - description: Phytec phyCORE-RK3288 Rapid Development Kit
> +        items:
> +          - const: phytec,rk3288-pcm-947
> +          - const: phytec,rk3288-phycore-som
> +          - const: rockchip,rk3288
> +
> +      - description: Google Mickey (Asus Chromebit CS10)
> +        items:
> +          - const: google,veyron-mickey-rev8
> +          - const: google,veyron-mickey-rev7
> +          - const: google,veyron-mickey-rev6
> +          - const: google,veyron-mickey-rev5
> +          - const: google,veyron-mickey-rev4
> +          - const: google,veyron-mickey-rev3
> +          - const: google,veyron-mickey-rev2
> +          - const: google,veyron-mickey-rev1
> +          - const: google,veyron-mickey-rev0
> +          - const: google,veyron-mickey
> +          - const: google,veyron
> +          - const: rockchip,rk3288
> +
> +      - description: Google Minnie (Asus Chromebook Flip C100P)
> +        items:
> +          - const: google,veyron-minnie-rev4
> +          - const: google,veyron-minnie-rev3
> +          - const: google,veyron-minnie-rev2
> +          - const: google,veyron-minnie-rev1
> +          - const: google,veyron-minnie-rev0
> +          - const: google,veyron-minnie
> +          - const: google,veyron
> +          - const: rockchip,rk3288
> +
> +      - description: Google Pinky (dev-board)
> +        items:
> +          - const: google,veyron-pinky-rev2
> +          - const: google,veyron-pinky
> +          - const: google,veyron
> +          - const: rockchip,rk3288
> +
> +      - description: Google Speedy (Asus C201 Chromebook)
> +        items:
> +          - const: google,veyron-speedy-rev9
> +          - const: google,veyron-speedy-rev8
> +          - const: google,veyron-speedy-rev7
> +          - const: google,veyron-speedy-rev6
> +          - const: google,veyron-speedy-rev5
> +          - const: google,veyron-speedy-rev4
> +          - const: google,veyron-speedy-rev3
> +          - const: google,veyron-speedy-rev2
> +          - const: google,veyron-speedy
> +          - const: google,veyron
> +          - const: rockchip,rk3288
> +
> +      - description: Google Jaq (Haier Chromebook 11 and more)
> +        items:
> +          - const: google,veyron-jaq-rev5
> +          - const: google,veyron-jaq-rev4
> +          - const: google,veyron-jaq-rev3
> +          - const: google,veyron-jaq-rev2
> +          - const: google,veyron-jaq-rev1
> +          - const: google,veyron-jaq
> +          - const: google,veyron
> +          - const: rockchip,rk3288
> +
> +      - description: Google Jerry (Hisense Chromebook C11 and more)
> +        items:
> +          - const: google,veyron-jerry-rev7
> +          - const: google,veyron-jerry-rev6
> +          - const: google,veyron-jerry-rev5
> +          - const: google,veyron-jerry-rev4
> +          - const: google,veyron-jerry-rev3
> +          - const: google,veyron-jerry
> +          - const: google,veyron
> +          - const: rockchip,rk3288
> +
> +      - description: Google Brain (dev-board)
> +        items:
> +          - const: google,veyron-brain-rev0
> +          - const: google,veyron-brain
> +          - const: google,veyron
> +          - const: rockchip,rk3288
> +
> +      - items:
> +          - enum:
> +              - rockchip,kylin-rk3036
> +          - const: rockchip,rk3036
> +
> +      - items:
> +          - enum:
> +              - haoyu,marsboard-rk3066
> +              - mundoreader,bq-curie2
> +              - chipspark,rayeager-px2
> +              - rikomagic,mk80
> +          - const: rockchip,rk3066a
> +
> +      - items:
> +          - enum:
> +              - radxa,rock
> +          - const: rockchip,rk3188
> +
> +      - items:
> +          - const: rockchip,px3-evb
> +          - const: rockchip,px3
> +          - const: rockchip,rk3188
> +
> +      - items:
> +          - enum:
> +              - firefly,roc-rk3328-cc
> +              - pine64,rock64
> +              - rockchip,rk3328-evb
> +          - const: rockchip,rk3328
> +
> +      - items:
> +          - enum:
> +              - geekbuying,geekbox
> +              - rockchip,rk3368-evb-act8846
> +              - rockchip,r88
> +              - tsd,rk3368-uq7-haikou
> +              - tronsmart,orion-r68-meta
> +          - const: rockchip,rk3368
> +
> +      - items:
> +          - enum:
> +              - geekbuying,geekbox
> +              - rockchip,rk3368-evb-act8846
> +              - rockchip,r88
> +              - tsd,rk3368-uq7-haikou
> +              - tronsmart,orion-r68-meta
> +          - const: rockchip,rk3368
> +
> +      - items:
> +          - const: rockchip,px5-evb
> +          - const: rockchip,px5
> +          - const: rockchip,rk3368
> +
> +      - items:
> +          - enum:
> +              - firefly,firefly-rk3399
> +              - rockchip,rk3399-evb
> +              - rockchip,rk3399-sapphire
> +              - rockchip,rk3399-sapphire-excavator
> +              - tsd,rk3399-q7-haikou
> +              - vamrs,ficus
> +          - const: rockchip,rk3399
> +
> +      - description: Google Bob (Asus Chromebook Flip C101PA)
> +        items:
> +          - const: google,bob-rev13
> +          - const: google,bob-rev12
> +          - const: google,bob-rev11
> +          - const: google,bob-rev10
> +          - const: google,bob-rev9
> +          - const: google,bob-rev8
> +          - const: google,bob-rev7
> +          - const: google,bob-rev6
> +          - const: google,bob-rev5
> +          - const: google,bob-rev4
> +          - const: google,bob
> +          - const: google,gru
> +          - const: rockchip,rk3399
> +
> +      - description: Google Gru (dev-board)
> +        items:
> +          - const: google,gru-rev15
> +          - const: google,gru-rev14
> +          - const: google,gru-rev13
> +          - const: google,gru-rev12
> +          - const: google,gru-rev11
> +          - const: google,gru-rev10
> +          - const: google,gru-rev9
> +          - const: google,gru-rev8
> +          - const: google,gru-rev7
> +          - const: google,gru-rev6
> +          - const: google,gru-rev5
> +          - const: google,gru-rev4
> +          - const: google,gru-rev3
> +          - const: google,gru-rev2
> +          - const: google,gru
> +          - const: rockchip,rk3399
> +
> +      - description: Google Kevin (Samsung Chromebook Plus)
> +        items:
> +          - const: google,kevin-rev15
> +          - const: google,kevin-rev14
> +          - const: google,kevin-rev13
> +          - const: google,kevin-rev12
> +          - const: google,kevin-rev11
> +          - const: google,kevin-rev10
> +          - const: google,kevin-rev9
> +          - const: google,kevin-rev8
> +          - const: google,kevin-rev7
> +          - const: google,kevin-rev6
> +          - const: google,kevin
> +          - const: google,gru
> +          - const: rockchip,rk3399
> +
> +      - items:
> +          - enum:
> +              - rockchip,rv1108-evb
> +          - const: rockchip,rv1108
> +
> +      - items:
> +          - enum:
> +              - rockchip,rk3228-evb
> +          - const: rockchip,rk3228
> +
> +      - items:
> +          - enum:
> +              - rockchip,rk3229-evb
> +          - const: rockchip,rk3229
> +...
> 




