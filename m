Return-Path: <scottwood@freescale.com>
Message-ID: <48405E86.7090400@freescale.com>
Date: Fri, 30 May 2008 15:07:34 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/4] [POWERPC] 85xx: support for the TQM8548 module using
	the big Flash
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>	<1212130188-28835-2-git-send-email-wg@grandegger.com>	<1212130188-28835-3-git-send-email-wg@grandegger.com>
	<F90E02DE-8497-4E97-8891-B09D4302F423@kernel.crashing.org>
In-Reply-To: <F90E02DE-8497-4E97-8891-B09D4302F423@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> +        mpic: pic@40000 {
>> +            clock-frequency = <0>;
> remove clock-frequency

Where would one express the PIC timer frequency, then?

> 
>>
>> +            interrupt-controller;
>> +            #address-cells = <0>;
>> +            #interrupt-cells = <2>;
>> +            reg = <0x40000 0x40000>;
>> +            compatible = "chrp,open-pic";
>> +            device_type = "open-pic";
>> +                        big-endian;
> 
> remove big-endian.

I thought this was part of the open-pic binding.

In any case, if these are to go, we should remove them from existing 
trees and from the examples in bwof.txt before complaining about them in 
new boards...

-Scott
