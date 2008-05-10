Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D5B3DDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 23:26:20 +1000 (EST)
In-Reply-To: <Pine.SOC.4.64.0805101448580.8450@math.ut.ee>
References: <Pine.SOC.4.64.0805101448580.8450@math.ut.ee>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2b70b1438132c0ff12583c7bf9d96cc1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: ppc compile failure (__flush_icache_range etc undeclared)
Date: Sat, 10 May 2008 15:26:07 +0200
To: Meelis Roos <mroos@linux.ee>
Cc: linuxppc-dev@ozlabs.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Tried 2.6.26-rc1+git on ppc (arch/ppc, PReP subarch) and got this:
>
> arch/ppc/kernel/ppc_ksyms.c: At top level:
> arch/ppc/kernel/ppc_ksyms.c:152: error: '__flush_icache_range' 
> undeclared here (not in a function)

That's fixed by [2/3] in 
http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056010.html


Segher
