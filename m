Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 187ACDDFC3
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:54:27 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m09JsO6E025022
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 14:54:24 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m09JsM0Q127690
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 12:54:22 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m09JsLFm011350
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 12:54:22 -0700
Date: Wed, 9 Jan 2008 13:54:03 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] Miscellaneous for Taco
Message-ID: <20080109135403.7dd3949e@zod.rchland.ibm.com>
In-Reply-To: <47852000.20503@pikatech.com>
References: <477F13C0.7040006@pikatech.com> <1199566583.7291.63.camel@pasglop>
	<4783C3E8.3090107@pikatech.com> <200801082023.11475.sr@denx.de>
	<478503B6.3060402@pikatech.com>
	<20080109131807.4cb2af29@zod.rchland.ibm.com>
	<47852000.20503@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 09 Jan 2008 14:26:56 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Josh Boyer wrote:
> > On Wed, 09 Jan 2008 12:26:14 -0500
> > Sean MacLennan <smaclennan@pikatech.com> wrote:
> >
> >   
> >> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> >>     
> >
> > This one needs to go to the linux-usb list and David Brownell.
> >
> > Although I'm not sure what the benefit here really is.  You can still
> > set this in the defconfig without adding this patch...  I don't see a
> > need to do a default.
> >   
> Without the default, I was unable to select this option. I may have 
> solved it the wrong way. It seems if there is no string after the 
> tristate or boolean, you are not allowed to set the variable, it can 
> only default. So with no default, I cannot enable this option and 
> therefore cannot enable the ohci driver.
> 
> Again, I think the "default PCI" case catches most boards and all 
> PCI-less, or possibly PCI-less, boards need a default.

Ah, possibly.  Did you try doing a 'select USB_ARCH_HAS_OHCI' in the
config 440EP section of arch/powerpc/platforms/44x/Kconfig?

I'm just trying to save you some trouble.  There's nothing actually
wrong with your patch now, other than it has to be sent to the right
maintainer.

josh
