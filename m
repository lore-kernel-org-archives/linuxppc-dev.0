Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id C8960DDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 22:15:25 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l6HCFNkE009626
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 15:15:23 +0300
Date: Tue, 17 Jul 2007 15:15:15 +0300
To: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: regarding cpm_uart and platform_bus_type
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
References: <op.tvlxc2sjnhx3hy@phoenix>
Message-ID: <op.tvlyyor0nhx3hy@phoenix>
In-Reply-To: <op.tvlxc2sjnhx3hy@phoenix>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hm, it seems that, after all, cpm_uart works fine without any board  
specific code whatsoever. Sorry about the fuss. My mistake

Regards

Alex


On Tue, 17 Jul 2007 14:55:30 +0300, Alexandros Kostopoulos  
<akostop@inaccessnetworks.com> wrote:

> Hi all,
>
> I was wondering, since arch/powerpc is now based on device trees,  
> shouldn't the cpm_uart driver (or at least a branch of it for  
> arch/powerpc) be changed to use of_platform_bus_type instead of  
> platform_bus_type? In my opinion, cpm_uart driver should take all its  
> configuration (uart address base, ints etc) from dts (via the  
> of_platform code) without any intervention from board specific code. In  
> any case, given the current situation, how can I pass cpm_uart the  
> address/irq of the uarts? by hardcoding it in my board specific code?  
> mpc82xx_ads.c doesn't seem to have such code, and I was wondering how  
> SCC uarts work in this platform? Who initializes them?
>
> thank you
>
> Alex
