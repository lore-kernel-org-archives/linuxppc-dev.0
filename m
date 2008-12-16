Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81400DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 10:00:33 +1100 (EST)
Message-Id: <40363DF0-BC55-4872-AF73-1ED0B24F6224@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: bterrell <bterrell@empirix.com>
In-Reply-To: <21042870.post@talk.nabble.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: MPC8572 - IPR Register
Date: Tue, 16 Dec 2008 17:00:25 -0600
References: <BD261180E6D35F4D9D32F3E44FD3D9010F59452A@EMPBEDEX.empirix.com>
	<A7BF6E08-786A-4D00-BBEA-1568939722E9@kernel.crashing.org>
	<21042870.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 16, 2008, at 4:08 PM, bterrell wrote:

>
>
> Kumar Gala-3 wrote:
>>
>>
>> <1. Which PCIe port is the device on?
>> 2. is this a INT-X style or MSI interrupt?
>> 3. if INT-X is INT-A, B, C, D?
>>
>> - k
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>>
>
> He was posting a question for me.  The external device (PLX8616
> non-transparent bridge) which is sending the interrupt is connected  
> to the
> first PCIE controller.  The PCIE controller is configured in RC mode  
> and is
> "x4".  I'm using legacy (INTx) interrupts from the external switch  
> NTB port.
> The NTB port always generates INTA, but is swizzled by the upstream  
> port of
> the PLX8616 switch, so it comes to the PCIE controller as INTB I  
> believe.
>
> It works fine when the the 8572 and 8616 both start after power-on  
> reset.
> Can send multiple interrupts and each is acknowledged properly.   
> However,
> after I generate a "hot reset" event from the PCIE controller to the
> upstream port on the 8616 (or link goes down/up), it no longer seems  
> to
> propagate the INTx interrupt to the CPU.  Either the 8616 is not  
> sending the
> interrrupt or the 8572 is ignoring/masking it.  I'm trying to  
> determine
> which device is at fault.  I don't have access to a PCIE analyzer at  
> the
> moment.  Looking for some more visibility into received interrupts  
> within
> the 8572 PCIE or MPIC.
>
> FYI, I have not tried MSI yet but will soon.

So I'll ask the same questions.  I can point you at some registers to  
look at but wanted the details I asked about earlier.

- k
