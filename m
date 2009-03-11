Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 642E1DE213
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 02:42:34 +1100 (EST)
Message-Id: <A0ED6D80-FD02-4BED-B50B-7F3028E47888@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Mark Bishop <mark@bish.net>
In-Reply-To: <20090311115234.7hmj4jj79csgk4wo@www.bish.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Freescale MPC8313ERDB-RevA and newer BSP/kernel
Date: Wed, 11 Mar 2009 10:42:19 -0500
References: <20090311115234.7hmj4jj79csgk4wo@www.bish.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2009, at 10:52 AM, Mark Bishop wrote:

> Has anyone been able to get a newer Freescale BSP to work with a  
> RevA (processor version 1.0) RDB?
>
> The boards we received didn't have SPI compiled into the kernel and  
> when we went to go re-compile the kernel using the 20081222 and  
> 20080711 BSPs.  I realize that the interrupts were reversed for  
> eTEC1 and eTEC2 and I've made the changes in the .dtb file and I no  
> longer hang when I ping, etc.   But I still can't get the board on  
> the network.  I've verified it isn't the network settings.
>
> I've pinged Freescale for support (didn't help much) and I am now  
> looking for someone who has actually done it (if ever).

Have you tried a kernel.org kernel?  The group here would be more than  
happy to help with any issues you might find with the kernel.org kernel.

- k
