Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 5945DB6EFE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 06:14:46 +1100 (EST)
Date: Wed, 6 Jan 2010 11:14:25 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: i2c_powermac: Kernel access of bad area
In-Reply-To: <20100106173745.57207520@hyperion.delvare>
Message-ID: <alpine.DEB.2.01.1001061107350.3483@bogon.housecafe.de>
References: <alpine.DEB.2.01.0912281934170.3483@bogon.housecafe.de>
	<1262079255.2173.216.camel@pasglop>
	<20100106173745.57207520@hyperion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 6 Jan 2010 at 17:37, Jean Delvare wrote:
> Christian, did you happen to try removing the i2c-powermac driver
> before?

Well, I definitely removed the driver before, but I'm not sure if I ever 
read the /sys files after doing this :-\

> I am curious if this is a recent problem, possibly caused by
> changes to the i2c stack, or if older kernels already had this problem
> and nobody ever noticed. I suspect the latter.

Fair question, but I really could't tell. I realize a bisection would be 
helpful, but I don't think I'll have to time to do this on this machine 
(it's a PowerBook G4, but kernel still compilation usually takes ~30min) 
and I'm not sure that I care _that_ much about this particular issue. 
I just wanted to report this one, for the sake of the archives, as noone 
else seems to be bothered by it anyway...

> I think that sysfs files creation should be moved to the end of
> probe_thermostat() and sysfs files removal should be moved to the
> beginning of remove_thermostat(). Something like the totally untested
> patch below (no ppc machine at hand):

OK, thanks Jean - I'll give it a try later today and let you know.


Thanks again,
Christian.

-- 
BOFH excuse #398:

Data for intranet got routed through the extranet and landed on the internet.
