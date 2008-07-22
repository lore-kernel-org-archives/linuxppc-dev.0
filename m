Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 966A6DE015
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 03:56:40 +1000 (EST)
Date: Tue, 22 Jul 2008 12:55:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Duy-Ky Nguyen <duykynguyen@hotmail.com>
Subject: Re: Failure of request_irq()  for MPC8313 using arch=powerpc
Message-ID: <20080722175508.GA13940@loki.buserror.net>
References: <BLU119-DAV11096F9EACC27956DCC87BBB8F0@phx.gbl>
	<58A20A281BAF1047B4EAE68DE5C0BDC2010573E9@zch01exm21.fsl.freescale.net>
	<BLU119-DAV61F2F984D2E145D1E4AA1BB8F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BLU119-DAV61F2F984D2E145D1E4AA1BB8F0@phx.gbl>
Cc: Liu Dave <DaveLiu@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 08:43:59PM -0700, Duy-Ky Nguyen wrote:
> Hi Dave,
> 
> I've just tried it and it failed.

Could you elaborate on exactly what you tried?  Did you pass the GPIO device
tree node?

> Before I had tried using the function
> int virq = of_irq_to_resource(GPIO_IRQ, 0, NULL);
> and it failed the same way

The first argument of of_irq_to_resource is a device node pointer, not an
IRQ number.  Surely the compiler warned you about this.

-Scott
