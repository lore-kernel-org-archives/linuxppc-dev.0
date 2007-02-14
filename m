Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C7B87DDE06
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:30:34 +1100 (EST)
Message-ID: <45D29E75.1070008@freescale.com>
Date: Tue, 13 Feb 2007 23:30:29 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add of_get_mac_address() and update fsl_soc.c
	to use it
References: <1171408247467-git-send-email-timur@freescale.com>	
	<1171411219.20192.118.camel@localhost.localdomain>	
	<45D29B80.2060705@freescale.com>
	<1171430913.20192.134.camel@localhost.localdomain>
In-Reply-To: <1171430913.20192.134.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>> Are you saying that some device trees have something *other* than a MAC 
>> address in the 'address' property?
> 
> Yes, old Apple gear in some nodes, though I don't think in network
> devices...

Ok, then I will respin the patch with some more error checking.  Do you 
want me to just check the 'address' property, or all of the properties?
