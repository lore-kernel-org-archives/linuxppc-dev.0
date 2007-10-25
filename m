Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id E87E0DDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 00:56:03 +1000 (EST)
Message-ID: <4720AE67.3060902@semihalf.com>
Date: Thu, 25 Oct 2007 16:55:35 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 02/11] [POWERPC] Add 'lpb' bus type for MPC5200	LocalPlus
	Bus
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>	<20071023231315.29359.87832.stgit@hekate.izotz.org>
	<20071024000941.GA10926@lixom.net>
In-Reply-To: <20071024000941.GA10926@lixom.net>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> 
> On Wed, Oct 24, 2007 at 01:13:15AM +0200, Marian Balakowicz wrote:
>> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
>> ---
> 
> Your patch lacks any kind of description beyond the title. (I know, it's a
> real simple patch, but a real simple description would do too :)

All right, will add one.

> 
>> --- a/arch/powerpc/kernel/of_platform.c
>> +++ b/arch/powerpc/kernel/of_platform.c
>> @@ -49,6 +49,7 @@ static struct of_device_id of_default_bus_ids[] = {
>>  	{ .type = "plb4", },
>>  	{ .type = "opb", },
>>  	{ .type = "ebc", },
>> +	{ .type = "lpb", },
> 
> I thought it was consensus to keep the new bus ids only in platform
> code and not add them to the default list, and just pass that list in
> to of_platform_bus_probe().

Sounds reasonable, will move it to the 5xxx platform code.

Cheers,
m.
