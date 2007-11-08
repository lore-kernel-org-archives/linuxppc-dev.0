Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B20C1DDE9E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 02:56:37 +1100 (EST)
Message-ID: <473331B0.4040702@freescale.com>
Date: Thu, 08 Nov 2007 09:56:32 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 4/3] Make swsusp_32.S usable for suspend-to-RAM.
References: <20070905220846.GA11400@ld0162-tx32.am.freescale.net>
	<1194438345.4470.4.camel@johannes.berg>
In-Reply-To: <1194438345.4470.4.camel@johannes.berg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg wrote:
>> +config PPC32_SUSPEND
> 
>> +config PPC32_SWSUSP
> 
>> -obj32-$(CONFIG_HIBERNATION) += swsusp_32.o
>> +obj32-$(CONFIG_PPC32_SUSPEND)	+= swsusp_32.o
> 
> I think that's overkill, couldn't it just use CONFIG_PM_SLEEP here?

This file is specific to 32-bit classic PPC chips.

It doesn't matter, though, as I've redone the 83xx suspend to not need 
that file.

-Scott
