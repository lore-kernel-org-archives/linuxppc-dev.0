Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 64570DED19
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 03:19:15 +1000 (EST)
Message-ID: <48482011.5030704@grandegger.com>
Date: Thu, 05 Jun 2008 19:19:13 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
References: <4847AC75.8080405@grandegger.com>
	<71165662-0864-4CDE-A1B3-29487253B85F@kernel.crashing.org>
In-Reply-To: <71165662-0864-4CDE-A1B3-29487253B85F@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Jun 5, 2008, at 4:05 AM, Wolfgang Grandegger wrote:
> 
>> [POWERPC] 85xx: add board support for the TQM8548 modules
>>
>> This patch adds support for the TQM8548 modules from TQ-Components
>> GmbH (http://www.tqc.de).
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
[...deletions...]
>> ===================================================================
>> --- linux-2.6-galak.orig/arch/powerpc/boot/wrapper
>> +++ linux-2.6-galak/arch/powerpc/boot/wrapper
>> @@ -177,7 +177,7 @@ cuboot*)
>>    *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555|*-ksi8560*)
>>        platformo=$object/cuboot-85xx-cpm2.o
>>        ;;
>> -    *-mpc85*|*-tqm8540|*-sbc85*)
>> +    *-mpc85*|*-tqm8540|*-tqm8548|*-sbc85*)
> 
> why not just *-tqm85*

Hm, yes, *-tqm85* should cover all TQM85xx without CPM.

I just sent out v3 patches addressing this and all other issues. Hope
they are OK now.

Wolfgang.
