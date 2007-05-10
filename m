Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7192BDDE1E
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 02:04:19 +1000 (EST)
In-Reply-To: <46433EFF.6030608@freescale.com>
References: <20070507182953.GH26920@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.64.0705092233070.29512@localhost.localdomain>
	<46433EFF.6030608@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7561FE26-2779-43C9-9D0E-9D4728E89F78@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 09/13] fsl_soc: Factor fsl_get_bus_freq() out of the wdt
	init.
Date: Thu, 10 May 2007 10:59:14 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 10, 2007, at 10:49 AM, Scott Wood wrote:

> Kumar Gala wrote:
>> On Mon, 7 May 2007, Scott Wood wrote:
>>> +u32 fsl_get_bus_freq(void)
>> Can we call this something more explicit, like fsl_get_sys_freq().
>> Otherwise this looks fine.
>
> It's bus-frequency in the device tree, not sys-frequency, and the  
> latter doesn't seem any more explicit to me...  What about  
> fsl_get_csb_freq()?

I suggested sys because the 83xx, 85xx, and 86xx all refer to it as  
the system bus. (well they do with regards to setting its frequency).

- k
