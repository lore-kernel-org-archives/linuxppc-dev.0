Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FBCD1A0341
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 07:20:19 +1100 (AEDT)
Message-ID: <1456258812.5360.22.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Rob Herring <robh@kernel.org>, Zhao Qiang <qiang.zhao@nxp.com>
Cc: leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 23 Feb 2016 14:20:12 -0600
In-Reply-To: <20160223201520.GA3354@rob-hp-laptop>
References: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
 <20160223201520.GA3354@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 1/7] QE: Add IC, SI and SIRAM document to device tree
 bindings.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-23 at 14:15 -0600, Rob Herring wrote:
> On Thu, Feb 18, 2016 at 09:06:06AM +0800, Zhao Qiang wrote:
> > Add IC, SI and SIRAM document of QE to
> > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> > 
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> > Changes for v2
> > 	- Add interrupt-controller in Required properties
> > 	- delete address-cells and size-cells for qe-si and qe-siram
> > 
> >  .../devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt  | 50
> > ++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> > index 4f89302..84052a7 100644
> > --- a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> > @@ -69,6 +69,56 @@ Example:
> >  	};
> >       };
> >  
> > +* Interrupt Controller (IC)
> > +
> > +Required properties:
> > +- compatible : should be "fsl,qe-ic".
> 
> > +- compatible : should be "fsl,qe-si".
> 
> > +- compatible : should be "fsl,qe-siram".
> 
> These compatible strings are all a bit generic and should have SoC 
> specific compatible strings.

I don't know about si/siram, but "fsl,qe-ic" has been around since 2008, so it
should be documented even if a more specific compatible is also added.

-Scott
