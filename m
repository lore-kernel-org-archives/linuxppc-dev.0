Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B13CFDDF04
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 02:19:24 +1000 (EST)
Message-Id: <C18725A1-6933-4044-89AA-DAED16253325@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0904150859y3d8cea6dv9f9b88cc4939e9df@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/85xx: Add P2020DS board support
Date: Wed, 15 Apr 2009 11:17:17 -0500
References: <1239810564-8403-1-git-send-email-galak@kernel.crashing.org>
	<ed82fe3e0904150859y3d8cea6dv9f9b88cc4939e9df@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Ted Peters <ted.peters@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2009, at 10:59 AM, Timur Tabi wrote:

> On Wed, Apr 15, 2009 at 10:49 AM, Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>
>> --- a/arch/powerpc/platforms/fsl_uli1575.c
>> +++ b/arch/powerpc/platforms/fsl_uli1575.c
>> @@ -57,7 +57,7 @@ static void __devinit early_uli5249(struct  
>> pci_dev *dev)
>>        unsigned char temp;
>>
>>        if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
>> -                       !machine_is(mpc8572_ds))
>> +                       !machine_is(mpc8572_ds) && ! 
>> machine_is(p2020_ds))
>>                return;
>
> Are we going to need to update this function every time we add a new
> board that has an ULI 1575 on it?  Can't we define some property in
> the device tree to handle this?

Seeing as I think this is the last board that will have the ULI 1575  
from us I don't think its worth it.

- k
