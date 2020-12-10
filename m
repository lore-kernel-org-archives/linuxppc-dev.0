Return-Path: <SRS0=IADO=FO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF3C4167B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 09:41:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BE2235F7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 09:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BE2235F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baikalelectronics.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cs8814K94zDqyH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 20:41:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=baikalelectronics.ru (client-ip=87.245.175.226;
 helo=mail.baikalelectronics.ru;
 envelope-from=sergey.semin@baikalelectronics.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=baikalelectronics.ru
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com
 [87.245.175.226])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Cs7S34nRxzDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 20:10:43 +1100 (AEDT)
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Mathias Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Kevin Hilman <khilman@baylibre.com>, Neil
 Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v6 15/19] dt-bindings: usb: meson-g12a-usb: Fix FL-adj
 property value
Date: Thu, 10 Dec 2020 12:09:39 +0300
Message-ID: <20201210090944.16283-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201210090944.16283-1-Sergey.Semin@baikalelectronics.ru>
References: <20201210090944.16283-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
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
Cc: devicetree@vger.kernel.org,
 Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
 linux-mips@vger.kernel.org, Rob Herring <robh@kernel.org>,
 linux-snps-arc@lists.infradead.org,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>,
 Manu Gautam <mgautam@codeaurora.org>, Andy Gross <agross@kernel.org>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 linux-amlogic@lists.infradead.org,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Roger Quadros <rogerq@ti.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

An empty snps,quirk-frame-length-adjustment won't cause any change
performed by the driver. Moreover the DT schema validation will fail,
since it expects the property being assigned with some value. So set
fix the example by setting a valid FL-adj value in accordance with
Neil Armstrong comment.

Link: https://lore.kernel.org/linux-usb/20201010224121.12672-16-Sergey.Semin@baikalelectronics.ru/
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

---

Note the same problem is in the DT source file
arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi .
---
 .../devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
index c0058332b967..1eda16dd4ee0 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
+++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
@@ -229,6 +229,6 @@ examples:
               interrupts = <30>;
               dr_mode = "host";
               snps,dis_u2_susphy_quirk;
-              snps,quirk-frame-length-adjustment;
+              snps,quirk-frame-length-adjustment = <0x20>;
           };
     };
-- 
2.29.2

