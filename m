Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6B47CDDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 21:26:43 +1000 (EST)
Message-ID: <46B310B8.8040909@ru.mvista.com>
Date: Fri, 03 Aug 2007 15:25:44 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] PowerPC 440EPx: Sequoia new EMAC support
References: <20070730152339.GA5126@ru.mvista.com>
	<20070802153551.2a8ad14d@weaponx.rchland.ibm.com>
In-Reply-To: <20070802153551.2a8ad14d@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Mon, 30 Jul 2007 19:23:39 +0400
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
>> The patch adds PHY support for the Sequoia board to the new EMAC driver and
>> enables NEW_EMAC for 440EPx Kconfig.
>> The phy code has been written by Stefan Roese.
>> This has been tested with the following version of the EMAC dirver:
>>
>> http://ozlabs.org/~dgibson/home/emac/powerpc-emac-new-20070516.patch
>>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> ---
>>  arch/powerpc/platforms/44x/Kconfig |    5 +---
>>  drivers/net/ibm_newemac/phy.c      |   39 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 41 insertions(+), 3 deletions(-)
>>
>> --- linux.orig/arch/powerpc/platforms/44x/Kconfig	2007-07-30 15:05:50.000000000 +0400
>> +++ linux/arch/powerpc/platforms/44x/Kconfig	2007-07-30 17:59:05.000000000 +0400
>> @@ -47,9 +47,8 @@
>>  config 440EPX
>>  	bool
>>  	select PPC_FPU
>> -# Disabled until the new EMAC Driver is merged.
>> -#	select IBM_NEW_EMAC_EMAC4
>> -#	select IBM_NEW_EMAC_ZMII
>> +	select IBM_NEW_EMAC_EMAC4
>> +	select IBM_NEW_EMAC_ZMII
> 
> Probably don't want this bit yet.  The EMAC driver isn't really merged
> yet.
> 
> josh

Actually, this one is intended for use as a separate Sequoia emac 
support patch until new emac is merged. May be I should submit it 
separately, not with the whole Sequoia bundle.
