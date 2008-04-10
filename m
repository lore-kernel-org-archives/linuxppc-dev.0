Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0CFC1DE5C0
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 01:15:05 +1000 (EST)
Message-Id: <1E5FE1B9-14F6-4358-86EF-260DBC327196@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200804011433.29841.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCHv4 0/5] cpm2: Reset the CPM at startup and fix the cpm_uart
	driver accordingly.
Date: Thu, 10 Apr 2008 10:14:56 -0500
References: <200804011433.29841.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 1, 2008, at 7:33 AM, Laurent Pinchart wrote:
> Hi everybody,
>
> these 5 patches reset the CPM in cpm2_reset() and fix the cpm_uart  
> driver to
> initialise SMC ports correctly without relying on any initialisation
> performed by the boot loader/wrapper. They update the boot wrapper  
> code and
> the EP8248E device tree to match the new SMC registers description.
>
> Patches 2/5, 3/5 and 4/5 (boot wrapper and EP8248E device tree  
> updates)
> haven't been tested due to lack of hardware.

applied.

- k
