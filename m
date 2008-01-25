Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 030B5DE291
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 03:05:11 +1100 (EST)
Message-ID: <479A087F.5010305@scram.de>
Date: Fri, 25 Jan 2008 17:04:15 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] [NET]: Remove PowerPC code from fec.c
References: <4799F349.9090102@scram.de> <E1JIQpQ-0006Xj-RR@faramir.fjphome.nl>
In-Reply-To: <E1JIQpQ-0006Xj-RR@faramir.fjphome.nl>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linux-m68k@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	geert@linux-m68k.org, gerg@uclinux.org, scottwood@freescale.com,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Frans,

> Jochen Friedrich wrote:
>> +++ b/drivers/net/fec.c
>> @@ -23,6 +23,9 @@
>>   *
>>   * Bug fixes and cleanup by Philippe De Muyter (phdm@macqel.be)
>>   * Copyright (c) 2004-2006 Macq Electronique SA.
>> + *
>> + * This driver is now only used on ColdFire processors. Remove conditional
>> + * Powerpc code. 
>>   */
> 
> This comment makes sense for a changelog, but IMO it makes no sense at all
> to add it to the file.

I just added it to clarify this code is now only used on m68knommu (Coldfire).
The comments on top are mailny about MPC860T CPUs (PowerPC), however the driver is no
longer used for these CPUs.

Maybe the wording should be changed to:

This driver is now only used on ColdFire (m68knommu) processors. Conditional
PowerPC code has been removed.

Thanks,
Jochen
