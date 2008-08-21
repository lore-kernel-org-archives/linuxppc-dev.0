Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 8A89FDDDD8
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 19:51:53 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Strange behavior with I2C on Sequoia board
Date: Thu, 21 Aug 2008 11:51:40 +0200
References: <48AC84D9.8050809@harris.com>
	<1219279463.26429.35.camel@jdub.homelinux.org>
	<20080820231828.3c22da08@lappy.seanm.ca>
In-Reply-To: <20080820231828.3c22da08@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808211151.40499.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 21 August 2008, Sean MacLennan wrote:
> > That's all output from the wrapper, not the kernel.  And the kernel
> > config doesn't make a difference at all to the wrapper.  I wonder if
> > there is some weird size issue going on there or if whatever U-Boot
> > version you are using is doing odd things...
>
> Any chance something in the DTS could affect it? Maybe try commenting
> out the second IIC controller?

Yes, I2C is generally working and should make a difference in Linux kernel 
booting.

It seems that your bootwrapper is somehow not copying the correct MAC address 
to the device-tree. Not sure what's going wrong here. We usually don't use 
the bootwrapper but boot the uImage directly from U-Boot on all 4xx systems.

You might want to debug the bootwrapper code, if possible drop the bootwrapper 
and use the uImage with a newer, device-tree enabled U-Boot version.

Best regards,
Stefan
