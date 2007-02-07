Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 955C9DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 09:16:47 +1100 (EST)
Message-ID: <45CA4FCC.1000706@freescale.com>
Date: Wed, 07 Feb 2007 16:16:44 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mac-address vs. local-mac-address
References: <45CA41F7.6020700@freescale.com>	
	<1170883956.2620.305.camel@localhost.localdomain>	
	<45CA47AB.1000302@freescale.com>
	<1170886032.2620.309.camel@localhost.localdomain>
In-Reply-To: <1170886032.2620.309.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> Without a firmware device tree, there's no way to update the device tree and 
>> have that new tree retained over a reboot.
> 
> I don't think it was ever question to update it over reboot...

Well, it is a good idea to use the same MAC address at every boot.  The question 
becomes: when you change the MAC address in Linux, is it possible to retain that 
value over reboot?  If the driver were able to update the *real* OF tree, then 
we could provide that functionality (on OF-enabled systems).

My main point was to define when mac-address should be used, and when 
local-mac-address should be used.

> mac-address is a runtime property that is lost at reboot, at least
> that's my understanding of the OF behaviour. That's where your confusion
> is.

Linux already stores the current MAC address somewhere outside of the OF tree. 
When I reboot the system, does Linux store the current MAC address somewhere?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
