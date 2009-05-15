Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6759DE0E0
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 22:48:55 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n4FCmm72032536
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 07:48:48 -0500
Message-Id: <B61716E7-FFBA-4FED-A846-8864EE16C81C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: git tree w/swiotlb/36-bit physical support for MPC8641/MPC85xx
Date: Fri, 15 May 2009 07:48:47 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For those that care and have an interest I've posted a 'swiotlb'  
branch that includes all the patches needed for running with large  
amounts of memory on MPC8641 or MPC85xx based systems.  This branch is  
based on v2.6.30-rc5 + next branch + core swiotlb patches

	git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git swiotlb

The expectation is all this code will be in 2.6.31.

If you have any issues please let me know.

- k
