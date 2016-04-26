Return-Path: <tony@atomide.com>
Received: from muru.com (muru.com [72.249.23.125])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvStT65PPzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 02:17:53 +1000 (AEST)
Date: Tue, 26 Apr 2016 09:08:31 -0700
From: Tony Lindgren <tony@atomide.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lee Jones <lee@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 04/14] ARM: dts: OMAP36xx: : DT spelling
 s/#address-cell/#address-cells/
Message-ID: <20160426160831.GT5995@atomide.com>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-5-git-send-email-geert+renesas@glider.be>
 <CAL_JsqKSbGPKNZdZnowGpdF8zxXbh6g-wkq96+KmBNLwp7n=HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqKSbGPKNZdZnowGpdF8zxXbh6g-wkq96+KmBNLwp7n=HQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Rob Herring <robh+dt@kernel.org> [160420 16:48]:
> On Wed, Apr 20, 2016 at 10:32 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  arch/arm/boot/dts/omap36xx.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> > index ce1e242d4dc07ea8..8b797915300894d8 100644
> > --- a/arch/arm/boot/dts/omap36xx.dtsi
> > +++ b/arch/arm/boot/dts/omap36xx.dtsi
> > @@ -44,7 +44,7 @@
> >                 abb_mpu_iva: regulator-abb-mpu {
> >                         compatible = "ti,abb-v1";
> >                         regulator-name = "abb_mpu_iva";
> > -                       #address-cell = <0>;
> > +                       #address-cells = <0>;
> 
> dtc should flag this if it was really needed. However, it looks like
> it isn't as there are no child nodes (unless the board files add
> them).
> 
> A nice dtc check would be to flag unnecessary #address-cells or
> #size-cells. That would only help here after your fix though.

Yeah. Applying patches 2 - 4 into omap-for-v4.7/dt thanks.

Tony
