Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0118.outbound.protection.outlook.com [157.56.111.118])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 466131A0707
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 11:24:25 +1100 (EST)
Message-ID: <1412641450.13320.509.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
From: Scott Wood <scottwood@freescale.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Date: Mon, 6 Oct 2014 19:24:10 -0500
In-Reply-To: <542FC6CC.4000507@c-s.fr>
References: <20141003164917.397871AB276@localhost.localdomain>
 <1412365908.13320.429.camel@snotra.buserror.net> <542FC6CC.4000507@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-10-04 at 12:07 +0200, christophe leroy wrote:
> The bindings for that driver are described in 
> Documentation/devicetree/bindings/spi/fsl-spi.txt. But it seems that it 
> doesn't describe anything related to those compatibles. The driver has a 
> match on "fsl,fsl-spi" only,

I think you mean "fsl,spi", and that's a terrible compatible name.

>  and for using it with CPM you have to add 
> "fsl,cpm1-spi" or "fsl,cpm2-spi" to tell the driver that it is CPM 
> (existing code below).

fsl-spi.txt doesn't describe CPM1/2 at all, but rather QE (CPM3) and
non-CPM.

-Scott
