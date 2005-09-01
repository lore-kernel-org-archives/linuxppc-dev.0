Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6542D68106
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2005 04:47:23 +1000 (EST)
In-Reply-To: <20050901183808.GA23764@localhost.localdomain>
References: <20050901183808.GA23764@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <86F3DB1B-C396-45F4-8DBA-87176648D143@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 1 Sep 2005 13:47:36 -0500
To: "Sven Luther" <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org, Christian <evil@g-house.de>
Subject: Re: use of rtc.c on chrp/prep?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 1, 2005, at 1:38 PM, Sven Luther wrote:

> On Thu, Sep 01, 2005 at 12:57:55PM -0500, Kumar Gala wrote:
>
>> Does anyone enable CONFIG_RTC on chrp/prep?  Tom tells me these are
>> the only platforms that it is even valid to do so on.
>>
>
> The debian powerpc kernels enables :
>
>   $ grep RTC /boot/config-2.6.12-1-powerpc
>   CONFIG_GEN_RTC=y
>   CONFIG_GEN_RTC_X=y
>
> and not the CONFIG_RTC variant, and it works well on pegasos, and prep
> boxes,
> and probably on ibm chrps too, altough i have not tested personally.

Thanks, as far as I can tell no one is using CONFIG_RTC, which means  
I can "fix" asm-ppc/mc146818rtc.h to no longer #define RTC_IRQ 8

- kumar
