Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80158DDFE3
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 06:19:10 +1100 (EST)
Message-ID: <47F28AA6.7040903@freescale.com>
Date: Tue, 01 Apr 2008 14:19:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv4 0/5] cpm2: Reset the CPM at startup and fix the cpm_uart
	driver accordingly.
References: <200804011433.29841.laurentp@cse-semaphore.com>
In-Reply-To: <200804011433.29841.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> Hi everybody,
> 
> these 5 patches reset the CPM in cpm2_reset() and fix the cpm_uart driver to 
> initialise SMC ports correctly without relying on any initialisation 
> performed by the boot loader/wrapper. They update the boot wrapper code and
> the EP8248E device tree to match the new SMC registers description.
> 
> Patches 2/5, 3/5 and 4/5 (boot wrapper and EP8248E device tree updates) 
> haven't been tested due to lack of hardware.

Tested OK on ep8248e.
ACK 1-5

-Scott
