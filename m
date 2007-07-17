Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id E815DDDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 21:55:38 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l6HBtaZ2009041
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:55:36 +0300
Received: from inaccessnetworks.com ([127.0.0.1])
	by localhost (host11.inaccessnetworks.com [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP id 08414-17 for <linuxppc-dev@ozlabs.org>;
	Tue, 17 Jul 2007 14:55:35 +0300 (EEST)
Received: from phoenix (phoenix.priv.inaccessnetworks.com [192.168.1.7])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l6HBtZ5M009036
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:55:35 +0300
Date: Tue, 17 Jul 2007 14:55:30 +0300
To: linuxppc-dev@ozlabs.org
Subject: regarding cpm_uart and platform_bus_type
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
Message-ID: <op.tvlxc2sjnhx3hy@phoenix>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I was wondering, since arch/powerpc is now based on device trees,  
shouldn't the cpm_uart driver (or at least a branch of it for  
arch/powerpc) be changed to use of_platform_bus_type instead of  
platform_bus_type? In my opinion, cpm_uart driver should take all its  
configuration (uart address base, ints etc) from dts (via the of_platform  
code) without any intervention from board specific code. In any case,  
given the current situation, how can I pass cpm_uart the address/irq of  
the uarts? by hardcoding it in my board specific code? mpc82xx_ads.c  
doesn't seem to have such code, and I was wondering how SCC uarts work in  
this platform? Who initializes them?

thank you

Alex
