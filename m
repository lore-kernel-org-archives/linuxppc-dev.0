Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id C6ACADDE39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 19:30:10 +1000 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	CF7B6100048Bfor <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 11:30:08 +0200 (CEST)
Message-ID: <46D53C82.8030308@fz-juelich.de>
Date: Wed, 29 Aug 2007 11:29:38 +0200
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Re: Newbie and linux on virtex-II ppc
References: <46D2C9A5.9030708@fz-juelich.de>
	<fa686aa40708270719s1fd230e9g188948ef02b3eda7@mail.gmail.com>
	<46D41298.7060109@fz-juelich.de>
	<fa686aa40708280606p67fd74p9287d041d955c538@mail.gmail.com>
	<46D4221D.8030500@fz-juelich.de>
	<fa686aa40708280630x67856334qaf2e0dd59ecb95bf@mail.gmail.com>
	<46D4257C.7060208@fz-juelich.de>
	<fa686aa40708280655mf0c08cct43eb9dbd75452690@mail.gmail.com>
	<46D42D40.9040204@fz-juelich.de>
	<fa686aa40708280743i7b3b4ef3g9df015e4be39a9cd@mail.gmail.com>
	<fa686aa40708280744g29cb8e17r6153271cd67117ed@mail.gmail.com>
In-Reply-To: <fa686aa40708280744g29cb8e17r6153271cd67117ed@mail.gmail.com>
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

Step by step i becomes running :)

kernel is booting, root-fs is mounting on systemace, busybox compiled
and rootfs installed (i used klingauf's mkrootfs)

but now it says:
[    2.964978] Freeing unused kernel memory: 92k init
[    3.081332] Warning: unable to open an initial console.
[    3.306406] request_module: runaway loop modprobe binfmt-4c46
[    3.375612] request_module: runaway loop modprobe binfmt-4c46
[    3.446800] request_module: runaway loop modprobe binfmt-4c46

and i don't know what this is :(

Can give me a hint, where to look ?

thx
Georg

Grant Likely wrote:
> On 8/28/07, Grant Likely <grant.likely@secretlab.ca> wrote:
>   
>> On 8/28/07, schardt <g.schardt@fz-juelich.de> wrote:
>>     
>>> Okay, im really blind i think, so i started again :
>>>
>>> - 2.6.22 kernel from kernel.org
>>> - cp /arch/ppc/configs/ml300_defconfig .config
>>>       
>
> BTW, "make ml300_defconfig" does this for you.
>
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
