Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id 2419167A78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 19:37:08 +1100 (EST)
Message-ID: <42427C2F.2070104@varma-el.com>
Date: Thu, 24 Mar 2005 11:37:03 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>	<556f5ce38ca914dce63ca24277af4b3e@freescale.com>
	<423FC578.8040202@246tNt.com>
In-Reply-To: <423FC578.8040202@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [RFC] MPC5200 PCI problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sylvain,

After last synchronization with your bk,
PCI subsys stop calling drv->probe of driver for
my external PCI board (UBoot meanwhile properly displayed and init this 
board). May be I do something wrong? Or PCI is in disjoint state now?

-- 
Regards
Andrey Volkov

P.S. HOTPLUG disabled in my conf.
