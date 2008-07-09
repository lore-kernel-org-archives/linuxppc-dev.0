Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id E72BADDF4E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jul 2008 17:03:18 +1000 (EST)
Message-ID: <48746347.7050107@coritel.it>
Date: Wed, 09 Jul 2008 09:05:43 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Siva Prasad <sprasad@bivio.net>
Subject: Re: RAMDISK: ran out of compressed data
References: <D83235F0F3C86D4D889D8B9A0DA8C6D702B63AD3@corpexc01.corp.networkrobots.com>
	<48730FFA.1070805@coritel.it>
	<D83235F0F3C86D4D889D8B9A0DA8C6D702B63C3B@corpexc01.corp.networkrobots.com>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D702B63C3B@corpexc01.corp.networkrobots.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Siva Prasad ha scritto:
> Hi,
> 
> The same ramdisk works fine for 2.6.15 kernel. We are just upgrading to
> a new version, and would like to get that ramdisk to work on the new one
> as well.
> 
> Can you please elaborate on what you mean by compression format. Mine
> currently use the standard .gz extension/compression.
> 
> Thanks
> Siva
> 
> 
> Siva Prasad ha scritto:
>> Hi,
>>
>> I am getting the following error when I tried to boot with ramdisk.
> Any
>> specific reason or clue why this is happening?
>>
>> RAMDISK: Compressed image found at block 0
>> RAMDISK: ran out of compressed data
>> invalid compressed format (err=1)
>>
>> I am running into this on 8641D runing 2.6.24-rc6 kernel. My .config
>> around block area are...
>>
>> CONFIG_BLK_DEV=y
>> # CONFIG_BLK_DEV_FD is not set
>> # CONFIG_BLK_CPQ_DA is not set
>> # CONFIG_BLK_CPQ_CISS_DA is not set
>> # CONFIG_BLK_DEV_DAC960 is not set
>> # CONFIG_BLK_DEV_UMEM is not set
>> # CONFIG_BLK_DEV_COW_COMMON is not set
>> CONFIG_BLK_DEV_LOOP=y
>> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
>> # CONFIG_BLK_DEV_NBD is not set
>> # CONFIG_BLK_DEV_SX8 is not set
>> CONFIG_BLK_DEV_RAM=y
>> CONFIG_BLK_DEV_RAM_COUNT=16
>> CONFIG_BLK_DEV_RAM_SIZE=49152
>> CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
>>
>> Thanks
>> Siva
>>
> 
> 
> I think it's not a kernel problem but a problem related with the 
> compression method instead. Check out how you are compressing the
> ramdisk.
> 
Yes, I meant a problem about gzip or bzip2, but if it works with 
2.6.15....I don't what is the problem.

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
