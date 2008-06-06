Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 051C2DDF4C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 12:20:33 +1000 (EST)
Date: Thu, 5 Jun 2008 22:20:31 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Stefan Roese" <sr@denx.de>
Subject: Re: [PATCH] PowerPC 44x: small warp-nand fix
Message-ID: <20080605222031.1b37eb49@lappy.seanm.ca>
In-Reply-To: <200806051628.18698.sr@denx.de>
References: <20080605133638.GA18021@ru.mvista.com>
	<200806051628.18698.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sean.maclennan@ottawa.kanatek.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jun 2008 16:28:18 +0200
"Stefan Roese" <sr@denx.de> wrote:

> n Thursday 05 June 2008, Valentine Barshak wrote:
> > The "ndfc-chip" device doesn't need any resources. All resources
> > are handled by the "ndfc-nand" device. Registering the same memory
> > resource twice causes "cat /proc/iomem" to go into an infinite loop
> > displaying NDFC memory addresses.
> >
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>  
> 
> Acked-by: Stefan Roese <sr@denx.de>
Acked-by: Sean MacLennan <smaclennan@pikatech.com>

Cheers,
  Sean
