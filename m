Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 081C5DDFD1
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 08:39:02 +1100 (EST)
Message-ID: <47B36405.9070406@mvista.com>
Date: Wed, 13 Feb 2008 14:41:25 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: create mpc85xx pci err platform device for
	EDAC
References: <20080211203445.GB5331@blade.az.mvista.com>
	<27AAC964-D9EE-435A-84FD-8A45FF27D448@kernel.crashing.org>
In-Reply-To: <27AAC964-D9EE-435A-84FD-8A45FF27D448@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Feb 11, 2008, at 2:34 PM, Dave Jiang wrote:
> 
>> Creating a platform device for the PCI error registers in order for  
>> the
>> mpc85xx EDAC driver to pick up proper resources. This is to prevent  
>> the
>> EDAC driver from monopolizing the of_device and thus preventing  
>> future PCI
>> code from using the PCI of_device(s).
>>
>> Signed-off-by: Dave Jiang <djiang@mvista.com>
> 
> I'd rather we didn't add new platform devices, but do this via  
> of_platform in the driver itself.

Kumar,
  Here's the thread of discussion between Arnd Bergmann and I why platform
device is used. The original patch was of_device based....

http://ozlabs.org/pipermail/linuxppc-dev/2007-July/thread.html

Does it still make sense or do I need to go back to of_device?

> 
> Also, we need to 'rename' the compatible field for some of these  
> devices.
> 
> - k
> 


-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
