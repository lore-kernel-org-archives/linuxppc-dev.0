Return-Path: <galak@kernel.crashing.org>
Message-Id: <5DDE0444-2F93-4670-BC5C-73281B7922C9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48405E86.7090400@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/4] [POWERPC] 85xx: support for the TQM8548 module using
	the big Flash
Date: Fri, 30 May 2008 15:10:37 -0500
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>	<1212130188-28835-2-git-send-email-wg@grandegger.com>	<1212130188-28835-3-git-send-email-wg@grandegger.com>
	<F90E02DE-8497-4E97-8891-B09D4302F423@kernel.crashing.org>
	<48405E86.7090400@freescale.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 30, 2008, at 3:07 PM, Scott Wood wrote:

> Kumar Gala wrote:
>>> +        mpic: pic@40000 {
>>> +            clock-frequency = <0>;
>> remove clock-frequency
>
> Where would one express the PIC timer frequency, then?
>
>>>
>>> +            interrupt-controller;
>>> +            #address-cells = <0>;
>>> +            #interrupt-cells = <2>;
>>> +            reg = <0x40000 0x40000>;
>>> +            compatible = "chrp,open-pic";
>>> +            device_type = "open-pic";
>>> +                        big-endian;
>> remove big-endian.
>
> I thought this was part of the open-pic binding.
>
> In any case, if these are to go, we should remove them from existing  
> trees and from the examples in bwof.txt before complaining about  
> them in new boards...

I've got a patch for this.  will update the examples in bwof.txt

- k
