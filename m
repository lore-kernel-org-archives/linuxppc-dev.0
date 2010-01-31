Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 3F067B7D40
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Jan 2010 17:06:02 +1100 (EST)
Date: Sat, 30 Jan 2010 22:05:26 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: i2c_powermac: Kernel access of bad area
In-Reply-To: <alpine.DEB.2.01.1001292202150.3483@bogon.housecafe.de>
Message-ID: <alpine.DEB.2.01.1001302156380.3483@bogon.housecafe.de>
References: <alpine.DEB.2.01.0912281934170.3483@bogon.housecafe.de>
	<1262079255.2173.216.camel@pasglop>
	<20100106173745.57207520@hyperion.delvare>
	<alpine.DEB.2.01.1001061913310.3483@bogon.housecafe.de>
	<20100107171738.2c83b13e@hyperion.delvare>
	<20100129091857.3b7228db@hyperion.delvare>
	<alpine.DEB.2.01.1001292202150.3483@bogon.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 29 Jan 2010 at 22:03, Christian Kujau wrote:
> On Fri, 29 Jan 2010 at 09:18, Jean Delvare wrote:
> > Christian, did you ever test this second patch of mine? If you did,
> > what was the outcome?

OK, I've now applied both the drivers/hwmon/ams/ patches and your earlier 
one for drivers/macintosh/therm_adt746x.c [0] to a current -git checkout 
and now I can unload i2c_powermac, list and read the remaining files in
/sys/devices/temperatures, load i2c_powermac again, and unload, and
load, and ... - it's wonderful! :-) No oopses so far.

Feel free to add a Tested-by: Christian Kujau <lists@nerdbynature.de>
so that the patches can be pushed into mainline.

Thanks for the fixes, Jean!

Christian.

[0] http://nerdbynature.de/bits/2.6.33-rc2/i2c_powermac/r2/
-- 
BOFH excuse #337:

the butane lighter causes the pincushioning
