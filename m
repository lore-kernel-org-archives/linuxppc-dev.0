Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 3DE48DDF31
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 00:18:02 +1000 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	361D1100089Cfor <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 16:18:01 +0200 (CEST)
Message-ID: <46D2DCFC.40401@fz-juelich.de>
Date: Mon, 27 Aug 2007 16:17:32 +0200
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Newbie and linux on virtex-II ppc
References: <46D2C9A5.9030708@fz-juelich.de>
	<fa686aa40708270609x453092eye6eaf83b65ac2dee@mail.gmail.com>
In-Reply-To: <fa686aa40708270609x453092eye6eaf83b65ac2dee@mail.gmail.com>
Content-Type: text/plain;
	charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 8/27/07, schardt <g.schardt@fz-juelich.de> wrote:
>   
>> im a student from germany and i try to run linux on a virtex-II with
>> integrated powerpc.
>> i use the developer board DS-DB-2VP4/7-FG456 from Memec ( i think its
>> now avnet)
>>
>> what is running :
>>
>>   - Xilinx EDK project (standalone program running fine, and BSP files
>> are generated)
>>     the project has only one UARTLITE, 82MB SDRAM and a few kByte
>> blockram, and the systemace interface
>>
>>   - crosscompiler toolchain works
>>
>>   - after modified some defines in the xparameters.h i got a linux 2.4.
>> kernel (linuxppc) without compiler errors
>>     
>
> I strongly recommend trying to bring up a 2.6 kernel, it's much easier.
>   
okay, i'll try it :)
>   
>>     and yes, the uartlite driver is enabled :)
>>     
>
> Don't modify xparams by hand; it's not worth the trouble.  Go into
> software setting in your EDK project and select 'linux-2.6' as the OS.
>  Generate the libraries and copy the generated xparameters_ml40x.h
> into your kernel tree.
>
>   
i dont have this option. do i need a update  ?


G





-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
Vorstand: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stellv. 
Vorsitzender)
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
