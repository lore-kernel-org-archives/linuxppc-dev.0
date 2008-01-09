Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 407ECDDEB7
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:26:57 +1100 (EST)
Message-ID: <47852000.20503@pikatech.com>
Date: Wed, 09 Jan 2008 14:26:56 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Miscellaneous for Taco
References: <477F13C0.7040006@pikatech.com><1199566583.7291.63.camel@pasglop><4783C3E8.3090107@pikatech.com><200801082023.11475.sr@denx.de><478503B6.3060402@pikatech.com>
	<20080109131807.4cb2af29@zod.rchland.ibm.com>
In-Reply-To: <20080109131807.4cb2af29@zod.rchland.ibm.com>
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
> On Wed, 09 Jan 2008 12:26:14 -0500
> Sean MacLennan <smaclennan@pikatech.com> wrote:
>
>   
>> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
>>     
>
> This one needs to go to the linux-usb list and David Brownell.
>
> Although I'm not sure what the benefit here really is.  You can still
> set this in the defconfig without adding this patch...  I don't see a
> need to do a default.
>   
Without the default, I was unable to select this option. I may have 
solved it the wrong way. It seems if there is no string after the 
tristate or boolean, you are not allowed to set the variable, it can 
only default. So with no default, I cannot enable this option and 
therefore cannot enable the ohci driver.

Again, I think the "default PCI" case catches most boards and all 
PCI-less, or possibly PCI-less, boards need a default.

Cheers,
   Sean
