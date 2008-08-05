Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1DFF2DDFD3
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 23:21:36 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m75DLWKN009463
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 08:21:33 -0500
Message-Id: <F2163BC0-08A2-4C17-AAE7-C37BD0CA66EA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: ppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: hang w/ppc6xx_defconfig related to 'simple-bus' compatible
Date: Tue, 5 Aug 2008 08:21:31 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to get the ppc6xx_defconfig booting on any 8641 (74xx/e600)  
system.  If I remove the 'simple-bus' compatible from the soc node in  
the .dts it works.  Otherwise it hangs at but and looks to be crashed  
in the serial driver due to accessing memory at 0.

I've tried the same .dts (w/'simple-bus') using the  
mpc8641_hpcn_defconfig and things work.

Any one got any ideas?

- k
