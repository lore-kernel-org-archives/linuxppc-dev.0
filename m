Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7FD05DDF53
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 08:17:56 +1000 (EST)
Message-ID: <485C2C8D.5030703@freescale.com>
Date: Fri, 20 Jun 2008 17:17:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/6] MPC5121 Add PCI support
References: <1213981119-1979-1-git-send-email-jrigby@freescale.com>	<1213981119-1979-2-git-send-email-jrigby@freescale.com>	<1213981119-1979-3-git-send-email-jrigby@freescale.com>	<1213981119-1979-4-git-send-email-jrigby@freescale.com>	<1213981119-1979-5-git-send-email-jrigby@freescale.com>	<1213981119-1979-6-git-send-email-jrigby@freescale.com>
	<A09E5DF4-4844-41E6-B30A-C3E08BE342EB@kernel.crashing.org>
In-Reply-To: <A09E5DF4-4844-41E6-B30A-C3E08BE342EB@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> diff --git a/arch/powerpc/platforms/512x/pci.c 
>> b/arch/powerpc/platforms/512x/pci.c
>> new file mode 100644
>> index 0000000..7ed9b34
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/512x/pci.c
>> @@ -0,0 +1,84 @@
>> +/*
>> + * Copyright (C) 2008 Freescale Semiconductor, Inc. All rights reserved.
>> + *
>> + * Original copied from 83xx/pci.c:
> 
> Can we not reuse the same code for 83xx/pci.c and 5121/pci?  and move it 
> into sysdev/fsl_pci.c?  (we'd add some ifdefs for 83xx & 5121)

I assume by "ifdefs" you mean "device tree checks", right? :-)

-Scott
