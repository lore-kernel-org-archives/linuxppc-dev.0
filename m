Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 89C79DE0A0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 07:10:14 +1100 (EST)
Message-ID: <47852A24.1040107@pikatech.com>
Date: Wed, 09 Jan 2008 15:10:12 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Miscellaneous for Taco
References: <477F13C0.7040006@pikatech.com><1199566583.7291.63.camel@pasglop><4783C3E8.3090107@pikatech.com><200801082023.11475.sr@denx.de><478503B6.3060402@pikatech.com><20080109131807.4cb2af29@zod.rchland.ibm.com><47852000.20503@pikatech.com>
	<20080109135403.7dd3949e@zod.rchland.ibm.com>
In-Reply-To: <20080109135403.7dd3949e@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
>
> Ah, possibly.  Did you try doing a 'select USB_ARCH_HAS_OHCI' in the
> config 440EP section of arch/powerpc/platforms/44x/Kconfig?
>
> I'm just trying to save you some trouble.  There's nothing actually
> wrong with your patch now, other than it has to be sent to the right
> maintainer.
>
> josh
>   

That works. Thanks!

Cheers,
   Sean
