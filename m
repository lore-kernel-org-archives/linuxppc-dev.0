Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8DAA2DDE01
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 01:41:27 +1100 (EST)
Message-ID: <45D5C292.2080904@freescale.com>
Date: Fri, 16 Feb 2007 08:41:22 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] powerpc: add of_get_mac_address() and update fsl_soc.c
	to use it
References: <11714756473819-git-send-email-timur@freescale.com>
	<17876.64475.232797.997009@cargo.ozlabs.ibm.com>
In-Reply-To: <17876.64475.232797.997009@cargo.ozlabs.ibm.com>
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

Paul Mackerras wrote:
> Timur Tabi writes:
> 
>> Add function of_get_mac_address(), which obtains the best MAC address to use
>> from the device tree by checking various properties in order.  The order is:
>> 'mac-address', then 'local-mac-address', then 'address'.  It skips properties 
>> that contain invalid MAC addresses, which were probably not initialized
>> by U-Boot.
> 
> Looks OK except that of_get_mac_address should go in prom_parse.c, not
> prom.c.

Ok, I'll submit another patch in a few hours.  I presume the prototype 
should stay in include/asm-powerpc/prom.h?
