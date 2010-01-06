Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 738FFB6EEF
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 15:34:03 +1100 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.54])
	by hrndva-qmta02.mail.rr.com with ESMTP
	id <20100106041851122.ZZMT1979@hrndva-qmta02.mail.rr.com>
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jan 2010 04:18:51 +0000
Received: from [192.168.1.20] (millhouse.elkhashab.com [192.168.1.20])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	o064HkV9017540
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Jan 2010 22:17:46 -0600
Message-ID: <4B440EDC.3060805@elkhashab.com>
Date: Tue, 05 Jan 2010 22:17:32 -0600
From: Ayman El-Khashab <ayman@elkhashab.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: How to set GPIO state in the dts or in platform
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've got a custom board akin to the walnut.  I've successfully got u-boot,
the kernel, and a working filesystem.  The only thing I lack is a clear idea
of how to set a GPIO. 

I have the PHY reset connected to GPIO 3.  I've got it setup in u-boot
correctly, but by the time linux boots, it has touched the GPIOs and now the
PHY is held in reset.  I tried to follow how to adjust my device tree, 
but I
haven't been able to get it to work yet.  My kernel (circa mid 2008) 
doesn't
have the "keep" property of the GPIO node, so I can't use that. 

Based on what I've read it seems that I might need to add a node to the dts
and then a custom piece of code in the platform directory for my board.  I
am just not sure how to proceed there.

thanks
ayman
