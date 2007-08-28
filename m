Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 44966DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 23:25:17 +1000 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	01EF110009AFfor <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 15:25:14 +0200 (CEST)
Message-ID: <46D4221D.8030500@fz-juelich.de>
Date: Tue, 28 Aug 2007 15:24:45 +0200
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Re: Newbie and linux on virtex-II ppc
References: <46D2C9A5.9030708@fz-juelich.de>
	<fa686aa40708270609x453092eye6eaf83b65ac2dee@mail.gmail.com>
	<46D2CFFB.6050602@fz-juelich.de>
	<fa686aa40708270719s1fd230e9g188948ef02b3eda7@mail.gmail.com>
	<46D41298.7060109@fz-juelich.de>
	<fa686aa40708280606p67fd74p9287d041d955c538@mail.gmail.com>
In-Reply-To: <fa686aa40708280606p67fd74p9287d041d955c538@mail.gmail.com>
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
> On 8/28/07, schardt <g.schardt@fz-juelich.de> wrote:
>   
>> Hi Grant,
>>
>> i need your help again :)
>>
>> my 2.6. kernel is running. now i want to add the system ace driver to
>> mount a rootfs on the systemace-flash.
>> but i don't know how to import the EKD driver to the linux kernel, or is
>> there a ready to go driver in the kernel tree ?
>> i didn't find anything...
>>     
>
> You've got 2 choices:
> 1. use the new sysace driver; it's already in mainline.  The new
> driver is faster, but it doesn't handle hotswap of the CF card (yet)
>   
But where in menuconfig could i find the sysace driver ? i'm blind, i
think :)

> 2. use the EDK driver; easiest way is to use my tree which already has
> it merged:  http://git.secretlab.ca
>
>   
i made an EDK update and now i have the linux_2_2 os in the software
options. the bsp with all drivers is generated.
and now ?
 - copy to kernel tree 
 - use the xmake  to build the kernel, or make ?

and why is there no dokumentation :)

Thanks a lot
Georg


> Cheers,
> g.
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
