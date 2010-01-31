Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id 2B7E2B7D3F
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Jan 2010 20:52:35 +1100 (EST)
Date: Sun, 31 Jan 2010 10:52:31 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: i2c_powermac: Kernel access of bad area
Message-ID: <20100131105231.23d70990@hyperion.delvare>
In-Reply-To: <alpine.DEB.2.01.1001302156380.3483@bogon.housecafe.de>
References: <alpine.DEB.2.01.0912281934170.3483@bogon.housecafe.de>
	<1262079255.2173.216.camel@pasglop>
	<20100106173745.57207520@hyperion.delvare>
	<alpine.DEB.2.01.1001061913310.3483@bogon.housecafe.de>
	<20100107171738.2c83b13e@hyperion.delvare>
	<20100129091857.3b7228db@hyperion.delvare>
	<alpine.DEB.2.01.1001292202150.3483@bogon.housecafe.de>
	<alpine.DEB.2.01.1001302156380.3483@bogon.housecafe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stelian Pop <stelian@popies.net>,
	Michael Hanselmann <linux-kernel@hansmi.ch>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Jan 2010 22:05:26 -0800 (PST), Christian Kujau wrote:
> OK, I've now applied both the drivers/hwmon/ams/ patches and your earlier 
> one for drivers/macintosh/therm_adt746x.c [0] to a current -git checkout 
> and now I can unload i2c_powermac, list and read the remaining files in
> /sys/devices/temperatures, load i2c_powermac again, and unload, and
> load, and ... - it's wonderful! :-) No oopses so far.
> 
> Feel free to add a Tested-by: Christian Kujau <lists@nerdbynature.de>
> so that the patches can be pushed into mainline.

Thanks, I'll resend both patches with proper comments and headers now.

> Thanks for the fixes, Jean!

You're welcome.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
