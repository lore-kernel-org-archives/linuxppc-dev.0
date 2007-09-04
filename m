Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 7AA48DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 22:48:58 +1000 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	9C3101000189for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 14:48:56 +0200 (CEST)
Message-ID: <46DD5414.8010304@fz-juelich.de>
Date: Tue, 04 Sep 2007 14:48:20 +0200
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Re: Thanks and new problems
References: <46DD4B6A.3020401@fz-juelich.de> <46DD4F69.8060804@anagramm.de>
In-Reply-To: <46DD4F69.8060804@anagramm.de>
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

Ah, just found the problem in old postings

i've to use the 'a' Version of the IP-Core :)

Georg

Clemens Koller wrote:
> schardt schrieb:
>> First, many many thanks to Grant. My VirtexII Demo Board ist running a
>> 2.6. Linux :))
>>
>> But now, i switched to a Virtex4-Board with Ethernet (Mini Module from
>> Avnet)
>> This will i used in my application, if i can handle it. :)
>>
>> Linux is up and running, the ethernet is detected as eth0, link led
>> is on
>> but, and thats the problem, speed negotiating das not work.
>
> Check the PHY configuration (i.e. the bootstrap pins on the PHY).
>
> And - if appropriate - read out the PHY configuration (MDIO) and see
> if it's correct.
>
> Regards,



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
