Return-Path: <mark@bish.net>
Received: from vincent.bish.net (bish.net [209.241.232.100])
	by ozlabs.org (Postfix) with ESMTP id 8A7E9DDF25
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 23:27:12 +1100 (EST)
Received: from www-data by vincent.bish.net with local (Exim 4.63)
	(envelope-from <mark@bish.net>) id 1KqoWe-0005vU-QB
	for linuxppc-embedded@ozlabs.org; Fri, 17 Oct 2008 08:33:55 -0400
Message-ID: <20081017083352.hvn0g2q1es8skcwg@www.bish.net>
Date: Fri, 17 Oct 2008 08:33:52 -0400
From: Mark Bishop <mark@bish.net>
To: linuxppc-embedded@ozlabs.org
References: <20081016144526.tjuq1t5mgw4ks4co@www.bish.net>
	<48F8384A.6090901@coritel.it>
In-Reply-To: <48F8384A.6090901@coritel.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Subject: Re: How can I make flash writeable?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Ok, so bear with me.  I've read booting-without-of.txt in the =20
Documentation/powerpc directory and I modified a .dts file but now what?

I use ltib or u-boot to load that into the device or do I roll a =20
kernel with that file and flash the device with it?

Apologies for the less than technical questions.

Quoting Marco Stornelli <marco.stornelli@coritel.it>:

> Hi Mark,
>
>> How can I tell which devices are mapped to /proc/mtd devices?
>
> If I well understand the question, you'd like to change the partitions
> layout (?), so you should check out the dts file to see the flash
> layout, then you can specify there the partitions and change the
> dimensions, if they are read-only...and so on.
>
> Regards,
>
> Mark Bishop ha scritto:
>> I am using the MPC8313E-RDB and I am having some problems using the
>> flash that comes on the board.  Let me preface this by saying that I
>> haven't worked in the embedded linux arena in about 10 years so I am
>> trying to catch up with all the new toys.
>>
>> This board uses uBoot and it currently has 128M of DDR2, 8M flash and
>> 32M NAND Flash.  I have a few questions:
>>
>> How can I tell which memory device it uses to boot out of?
>> How can I tell which devices are mapped to /proc/mtd devices?
>>
>>
>> I want to create a writeable flash partition, is there a FAQ out there I
>> could look at.
>>
>> All of this is after a few days of using Google to try and glean some
>> data from the internet.  And the books don't get here from Amazon until
>> Monday.
>>
>> I would appreciate any help.  Even a RTFM - if you could point me to
>> TFM, it would greatly help.
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>
> --
> Marco Stornelli
> Embedded Software Engineer
> CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
> http://www.coritel.it
>
> marco.stornelli@coritel.it
> +39 06 72582838
>
>
