Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6640DE13D
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 04:39:42 +1000 (EST)
Message-Id: <8A8D87F8-A1DD-467D-8D83-CDC651B99F45@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080703182440.GA2576@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc: add FHCI USB, FSL MCU,
	FSL UPM and GPIO LEDs bindings
Date: Thu, 3 Jul 2008 13:39:34 -0500
References: <20080703174844.GA27966@polina.dev.rtsoft.ru>
	<EC062FA3-9CF8-4A94-95C7-2AAF22754A9C@kernel.crashing.org>
	<20080703182440.GA2576@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 3, 2008, at 1:24 PM, Anton Vorontsov wrote:

> On Thu, Jul 03, 2008 at 12:50:01PM -0500, Kumar Gala wrote:
>>
>> On Jul 3, 2008, at 12:48 PM, Anton Vorontsov wrote:
>>
>>> This patch adds few bindings for the new drivers to be submitted
>>> through
>>> the appropriate maintainers.
>>>
>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>> ---
>>>
>>> Segher, thanks for the comments on the previous version. Do you see
>>> any
>>> issues with this one or anything I could improve further?
>>>
>>> And if there are no issues... Kumar, could you apply this for
>>> powerpc-next?
>>>
>>> Thanks.
>>>
>>> Documentation/powerpc/booting-without-of.txt |  111 +++++++++++++++ 
>>> ++
>>> +++++++++
>>> 1 files changed, 111 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/Documentation/powerpc/booting-without-of.txt b/
>>> Documentation/powerpc/booting-without-of.txt
>>> index b68684d..a7ea549 100644
>>> --- a/Documentation/powerpc/booting-without-of.txt
>>> +++ b/Documentation/powerpc/booting-without-of.txt
>>> @@ -62,6 +62,10 @@ Table of Contents
>>>      s) Freescale on board FPGA
>>>      t) Freescael MSI interrupt controller
>>>      u) Freescale General-purpose Timers Module
>>> +      v) Freescale QUICC Engine USB Controller
>>> +      w) Freescale MCU with MPC8349E-mITX compatible firmware
>>
>> MCU doesn't mean much to me.  Its good to expand out the acronym at
>> least once.
>
> MCU stands for MicroController Unit, and even expanded this doesn't
> mean much to anybody. :-) Freescale documentation names it as boards'
> "MCU Subsystem", that is, the chip provides fan control, GPIOs,
> software halt, etc. Basically, it is boards' power management  
> companion
> chip. I don't know how to name it more correctly, so I adhered to
> documentation's naming (they simply call it MCU).
>
> ^^ I'll add some of these words to the node description though.

I agree, but MicroController lets me a know a bit more than the random  
letters M-C-U.  Just one reference in the heading is sufficient.

- k
