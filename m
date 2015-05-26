Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0147.outbound.protection.outlook.com [157.56.111.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D65F1A0D57
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 05:38:12 +1000 (AEST)
Message-ID: <1432669078.7862.13.camel@freescale.com>
Subject: Re: [PATCH V2] QorIQ/TMU: add TMU node to device tree for QorIQ T104x
From: Scott Wood <scottwood@freescale.com>
To: Jia Hongtao-B38951 <hongtao.jia@freescale.com>
CC: "edubezval@gmail.com" <edubezval@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "rui.zhang@intel.com"
 <rui.zhang@intel.com>
Date: Tue, 26 May 2015 14:37:58 -0500
In-Reply-To: <BLUPR03MB1498C018F80A754767DF48FE1CC0@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1429085868-47577-1-git-send-email-hongtao.jia@freescale.com>
 <BLUPR03MB1498C018F80A754767DF48FE1CC0@BLUPR03MB149.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-26 at 01:33 -0500, Jia Hongtao-B38951 wrote:
> Hi Scott,
> 
> Eduardo indicated that "calibration" property should add "fsl" 
> prefix.
> I updated the patch.
> Any other comments?
> If not I will send V3 soon.
> 
> Thanks.

I'd go with "fsl,tmu-calibration" rather than "fsl,calibration" but 
not a big deal either way.

> > diff --git a/arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi
> > b/arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi
> > new file mode 100644
> > index 0000000..d85c77d
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi
> > @@ -0,0 +1,82 @@
> > +/*
> > + * QorIQ TMU device tree stub [ controller @ offset 0xf0000 ]
> > + *
> > + * Copyright 2015 Freescale Semiconductor Inc.
> > + *
> > + * Redistribution and use in source and binary forms, with or 
> > without
> > + * modification, are permitted provided that the following 
> > conditions
> > are met:
> > + *     * Redistributions of source code must retain the above 
> > copyright
> > + *       notice, this list of conditions and the following 
> > disclaimer.
> > + *     * Redistributions in binary form must reproduce the above
> > copyright
> > + *       notice, this list of conditions and the following 
> > disclaimer in
> > the
> > + *       documentation and/or other materials provided with the
> > distribution.
> > + *     * Neither the name of Freescale Semiconductor nor the
> > + *       names of its contributors may be used to endorse or 
> > promote
> > products
> > + *       derived from this software without specific prior written
> > permission.
> > + *
> > + *
> > + * ALTERNATIVELY, this software may be distributed under the 
> > terms of
> > the
> > + * GNU General Public License ("GPL") as published by the Free 
> > Software
> > + * Foundation, either version 2 of that License or (at your 
> > option) any
> > + * later version.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' 
> > AND
> > ANY
> > + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
> > THE
> > IMPLIED
> > + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
> > PURPOSE
> > ARE
> > + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE 
> > LIABLE FOR
> > ANY
> > + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
> > CONSEQUENTIAL
> > DAMAGES
> > + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
> > GOODS OR
> > SERVICES;
> > + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
> > HOWEVER
> > CAUSED AND
> > + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
> > LIABILITY, OR
> > TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
> > THE USE
> > OF THIS
> > + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + */
> > +
> >  +tmu@f0000{
> > +   compatible = "fsl,qoriq-tmu";
> > +   reg = <0xf0000 0x1000>;
> > +   interrupts = <18 2 0 0>;
> > +   calibration = <0x00000000 0x0000000f
> > +                  0x00000001 0x00000017
> > +                  0x00000002 0x0000001e
> > +                  0x00000003 0x00000026
> > +                  0x00000004 0x0000002e
> > +                  0x00000005 0x00000035
> > +                  0x00000006 0x0000003d
> > +                  0x00000007 0x00000044
> > +                  0x00000008 0x0000004c
> > +                  0x00000009 0x00000053
> > +                  0x0000000a 0x0000005b
> > +                  0x0000000b 0x00000062
> > +
> > +                  0x00010000 0x00000011
> > +                  0x00010001 0x00000019
> > +                  0x00010002 0x00000021
> > +                  0x00010003 0x0000002a
> > +                  0x00010004 0x00000032
> > +                  0x00010005 0x0000003a
> > +                  0x00010006 0x00000042
> > +                  0x00010007 0x0000004b
> > +                  0x00010008 0x00000053
> > +                  0x00010009 0x0000005b
> > +                  0x0001000a 0x00000063
> > +
> > +                  0x00020000 0x00000012
> > +                  0x00020001 0x0000001b
> > +                  0x00020002 0x00000024
> > +                  0x00020003 0x0000002c
> > +                  0x00020004 0x00000035
> > +                  0x00020005 0x0000003d
> > +                  0x00020006 0x00000046
> > +                  0x00020007 0x0000004e
> > +                  0x00020008 0x00000057
> > +
> > +                  0x00030000 0x00000009
> > +                  0x00030001 0x00000011
> > +                  0x00030002 0x00000019
> > +                  0x00030003 0x00000021
> > +                  0x00030004 0x00000029
> > +                  0x00030005 0x00000031
> > +                  0x00030006 0x00000039
> > +                  0x00030007 0x00000041>;
> > +};
> > diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > index 15ae462..bb9f792 100644
> > --- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > @@ -345,6 +345,7 @@
> >             reg        = <0xea000 0x4000>;
> >     };
> > 
> > +/include/ "qoriq-tmu-t104xsi.dtsi"
> >  /include/ "elo3-dma-0.dtsi"
> >  /include/ "elo3-dma-1.dtsi"
> >  /include/ "qoriq-espi-0.dtsi"

Why is this chip-specific enough to be called "t104xsi", but not chip-
specific enough to just go directly into t1040si-post?

-SCott
