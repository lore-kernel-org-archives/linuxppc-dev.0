Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B2EB7DDDFC
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:26:10 +1100 (EST)
Message-ID: <4783C027.8080405@freescale.com>
Date: Tue, 08 Jan 2008 11:25:43 -0700
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/7] Basic Freescale MPC512x support
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<200801081907.59052.arnd@arndb.de>
In-Reply-To: <200801081907.59052.arnd@arndb.de>
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

Arnd Bergmann wrote:
> On Tuesday 08 January 2008, John Rigby wrote:
>   
>>  obj-$(CONFIG_PPC_CHRP)         += chrp/
>>  obj-$(CONFIG_40x)              += 40x/
>>  obj-$(CONFIG_44x)              += 44x/
>> +obj-$(CONFIG_PPC_512x)         += 512x/
>>  obj-$(CONFIG_PPC_MPC52xx)      += 52xx/
>>  obj-$(CONFIG_PPC_8xx)          += 8xx/
>>  obj-$(CONFIG_PPC_82xx)         += 82xx/
>>     
>
> Why do you name the directory 512x instead of 51xx, which would be
> more consistent with the others? Do you expect other 51xx chips that
> are mostly incompatible with 512x?
>   
51xx would be confusing because 5100 was a precursor to the 5200.

Adding it to 52xx would is wrong because 5121 is really not that
much like a 5200.  It is really a 83xx minus some networking hw
plus some 5200 peripherals (PSCs and MSCAN).

In the best of possible worlds it would have a 83xx part number
and go in 83xx but that would be confusing since it is targeted
at the automotive market.
> Moreover, is it really so different from 52xx that it needs a separate
> directory? E.g. we often treat the 74xx and 7xx as 6xx variants.
>
> 	Arnd <><
>
>   
