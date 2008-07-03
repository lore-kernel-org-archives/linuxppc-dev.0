Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A1BE4DDFAC
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 04:24:42 +1000 (EST)
Date: Thu, 3 Jul 2008 22:24:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add FHCI USB, FSL MCU, FSL UPM and GPIO LEDs
	bindings
Message-ID: <20080703182440.GA2576@polina.dev.rtsoft.ru>
References: <20080703174844.GA27966@polina.dev.rtsoft.ru>
	<EC062FA3-9CF8-4A94-95C7-2AAF22754A9C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <EC062FA3-9CF8-4A94-95C7-2AAF22754A9C@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 03, 2008 at 12:50:01PM -0500, Kumar Gala wrote:
>
> On Jul 3, 2008, at 12:48 PM, Anton Vorontsov wrote:
>
>> This patch adds few bindings for the new drivers to be submitted  
>> through
>> the appropriate maintainers.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>>
>> Segher, thanks for the comments on the previous version. Do you see  
>> any
>> issues with this one or anything I could improve further?
>>
>> And if there are no issues... Kumar, could you apply this for  
>> powerpc-next?
>>
>> Thanks.
>>
>> Documentation/powerpc/booting-without-of.txt |  111 +++++++++++++++++ 
>> +++++++++
>> 1 files changed, 111 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
>> Documentation/powerpc/booting-without-of.txt
>> index b68684d..a7ea549 100644
>> --- a/Documentation/powerpc/booting-without-of.txt
>> +++ b/Documentation/powerpc/booting-without-of.txt
>> @@ -62,6 +62,10 @@ Table of Contents
>>       s) Freescale on board FPGA
>>       t) Freescael MSI interrupt controller
>>       u) Freescale General-purpose Timers Module
>> +      v) Freescale QUICC Engine USB Controller
>> +      w) Freescale MCU with MPC8349E-mITX compatible firmware
>
> MCU doesn't mean much to me.  Its good to expand out the acronym at  
> least once.

MCU stands for MicroController Unit, and even expanded this doesn't
mean much to anybody. :-) Freescale documentation names it as boards'
"MCU Subsystem", that is, the chip provides fan control, GPIOs,
software halt, etc. Basically, it is boards' power management companion
chip. I don't know how to name it more correctly, so I adhered to
documentation's naming (they simply call it MCU).

^^ I'll add some of these words to the node description though.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
