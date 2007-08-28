Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id EBF1DDDF27
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 16:52:27 +1000 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	0739C100038Afor <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 08:52:26 +0200 (CEST)
Message-ID: <46D3C60D.5000703@fz-juelich.de>
Date: Tue, 28 Aug 2007 08:51:57 +0200
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
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

Good morning,

last night i got a 2.6. kernel ready and ive got a "Now booting the
kernel" message on the serial port *yeah* :)

... but nothing more :(

the __log_buffer says something like "Linux version ..."
is there a more useable way to read out the buffer ?  i use the xmd
debugger and the mrd command

Regards
Georg

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
>> but, when downloading the zImage.elf via XMD to the SDRAM and starting
>> it with the run command nothing happens , or  i think that nothings
>> happens because the serial port is quiet.
>>     
>
> You can always use System.map in the kernel tree to find out where
> __log_buf was linked to.  Look at that location with the debugger to
> see if there is a crash message that didn't get printed out.
>
>   
>> is it possible to run a kernel that way ? or need i some kind of
>> bootloader ?
>> or is this complete the wrong way ?
>>     
>
> Yes, I use this same method to bring up a kernel on Virtex boards
> which don't have a bootloader.
>
>   



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
