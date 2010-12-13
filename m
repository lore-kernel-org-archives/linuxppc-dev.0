Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 4A190B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 18:09:12 +1100 (EST)
Date: Mon, 13 Dec 2010 08:09:03 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/2] powerpc,
	mpc5200: update defconfig to fit with	2.6.37-rc4
In-reply-to: <20101212084707.GA14580@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Message-id: <4D05C68F.4030600@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <1292047981-1435-1-git-send-email-hs@denx.de>
	<20101212084707.GA14580@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

Wolfram Sang wrote:
> On Sat, Dec 11, 2010 at 07:13:00AM +0100, Heiko Schocher wrote:
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> I'd say the two patches can be merged. Dunno what Grant prefers whom you should
> CC as he is the maintainer.

I prefer the split in two patches, so we can see, what is added
by the charon board, and what by "make mpc5200_defconfig" ...

>> cc: Wolfram Sang <w.sang@pengutronix.de>
>> cc: linuxppc-dev@lists.ozlabs.org
>> ---
>> - based against 2.6.37-rc4
>> - I did the following steps to generate this patch:
>>
>>   make mpc5200_defconfig
>>   make savedefconfig
>>   cp ./defconfig arch/powerpc/configs/mpc5200_defconfig
>>
>>  arch/powerpc/configs/mpc5200_defconfig |    5 +----
>>  1 files changed, 1 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
>> index 7376e27..6f75623 100644
>> --- a/arch/powerpc/configs/mpc5200_defconfig
>> +++ b/arch/powerpc/configs/mpc5200_defconfig
>> @@ -1,5 +1,6 @@
>>  CONFIG_EXPERIMENTAL=y
>>  CONFIG_SYSVIPC=y
>> +CONFIG_SPARSE_IRQ=y
>>  CONFIG_LOG_BUF_SHIFT=14
>>  CONFIG_BLK_DEV_INITRD=y
>>  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>> @@ -20,7 +21,6 @@ CONFIG_PPC_BESTCOMM=y
>>  CONFIG_SIMPLE_GPIO=y
>>  CONFIG_NO_HZ=y
>>  CONFIG_HIGH_RES_TIMERS=y
>> -CONFIG_SPARSE_IRQ=y
>>  CONFIG_PM=y
>>  CONFIG_NET=y
>>  CONFIG_PACKET=y
>> @@ -52,7 +52,6 @@ CONFIG_PROC_DEVICETREE=y
>>  CONFIG_BLK_DEV_LOOP=y
>>  CONFIG_BLK_DEV_RAM=y
>>  CONFIG_BLK_DEV_RAM_SIZE=32768
>> -CONFIG_EEPROM_AT24=y
> 
> NACK.

... I did just the steps above mentioned, so this is
automagically done by "make mpc5200_defconfig" !

>>  CONFIG_SCSI_TGT=y
>>  CONFIG_BLK_DEV_SD=y
>>  CONFIG_CHR_DEV_SG=y
>> @@ -114,7 +113,6 @@ CONFIG_RTC_DRV_DS1307=y
>>  CONFIG_EXT2_FS=y
>>  CONFIG_EXT3_FS=y
>>  # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
>> -CONFIG_INOTIFY=y
> 
> Are you sure?

See comment above, did just the "make mpc5200_defconfig"
step ...

>>  CONFIG_MSDOS_FS=y
>>  CONFIG_VFAT_FS=y
>>  CONFIG_PROC_KCORE=y
>> @@ -132,5 +130,4 @@ CONFIG_PRINTK_TIME=y
>>  CONFIG_DEBUG_KERNEL=y
>>  CONFIG_DETECT_HUNG_TASK=y
>>  CONFIG_DEBUG_INFO=y
>> -# CONFIG_RCU_CPU_STALL_DETECTOR is not set
>>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
>> -- 
>> 1.7.2.3

Thanks for the review!

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
