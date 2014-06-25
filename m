Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B2CD1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 09:39:11 +1000 (EST)
Message-ID: <1403739540.2435.87.camel@snotra.buserror.net>
Subject: Re: [2/3,v4] powerpc/fsl-booke: Add initial T208x QDS board support
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Wed, 25 Jun 2014 18:39:00 -0500
In-Reply-To: <20140625232358.GA12402@home.buserror.net>
References: <1402481406-10830-2-git-send-email-Shengzhou.Liu@freescale.com>
 <20140625232358.GA12402@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-25 at 18:23 -0500, Scott Wood wrote:
> On Wed, Jun 11, 2014 at 06:10:05PM +0800, Shengzhou Liu wrote:
> > +			flash@2 {
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				compatible = "eon,en25s64";
> > +				reg = <2>;
> > +				spi-max-frequency = <35000000>;
> > +			};
> 
> I won't hold up this patch due to this, but you should send a patch to
> add eon to Documentation/devicetree/bindings/vendor-prefixes.txt.

at24, OTOH, looks wrong.  Shouldn't it be atmel?  How did "24" become
part of the vendor?  I see lots of existing uses, though...

-Scott
