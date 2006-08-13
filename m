Return-Path: <Rajan.Rai@ingenient.com>
Received: from mail.ingenient.com (unknown [63.87.52.245])
	by ozlabs.org (Postfix) with ESMTP id 6B32667C1B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Aug 2006 14:32:59 +1000 (EST)
Message-ID: <44DEAB23.10404@ingenient.com>
Date: Sun, 13 Aug 2006 00:31:31 -0400
From: Rajan Rai <Rajan.Rai@ingenient.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI driver on EB8347
References: <995B09A8299C2C44B59866F6391D2635018CA7@zch01exm21.fsl.freescale.net>
	<4DA89577C33E194ABEBC978921E858541B8E3B@exchange.ingenient.net>
	<94857DB0-ABC7-4AA5-BE5B-1CBEAA09D906@kernel.crashing.org>
	<44DDCAB8.80106@ingenient.com>
	<D9682BD5-FBDF-4D6C-BC82-6EF375DB6F46@kernel.crashing.org>
In-Reply-To: <D9682BD5-FBDF-4D6C-BC82-6EF375DB6F46@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Gala Kumar K.-galak" <kumar.gala@freescale.com>,
	Liu Dave-r63238 <DaveLiu@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar, Liu
                  I was able to resolve problem. Problem was in PCI card 
firmware and not in Linux Kernel  or driver.

                             Thanks for your help.
Regards,
-Rajan


Kumar Gala wrote:
>
> On Aug 12, 2006, at 7:34 AM, Rajan Rai wrote:
>
>>
>>
>>          Thanks IRQ problem is resolved. As  pointed out it was 
>> problem with IRQ IDSEL mapping. Mapping needs to be different on Eval 
>> board I'm using and our custom design. But my driver is still not 
>> working on our custom design. PCI device doesn't receive any messages 
>> from MPC8347 on our custom design mother board which uses pci-bridge 
>> where as it works fine on Eval board which doesn't use PCI bridge.
>>
>>                         I guess problem lies at the kernel level and 
>> not the driver. Any tips apart from IDSEL IRQ settings at kernel 
>> level what else I need to change when I move from 1 mother board to 
>> another.  My PCI  devices do get base address 0 and 1 allocated 
>> properly by the OS. But when I try to write any messages on those 
>> addresses PCI device doesn't see them
>
> Is the bridge getting configured correctly?  An lspci output would be 
> helpful from your system with the P2P bridge.
>
> - kumar
>
>
