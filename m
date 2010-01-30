Return-Path: <khali@linux-fr.org>
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124])
	by ozlabs.org (Postfix) with ESMTP id 324AFB7D35
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jan 2010 20:50:28 +1100 (EST)
Date: Sat, 30 Jan 2010 10:35:52 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: i2c_powermac: Kernel access of bad area
Message-ID: <20100130103552.284209fb@hyperion.delvare>
In-Reply-To: <1264800895.20211.120.camel@pasglop>
References: <alpine.DEB.2.01.0912281934170.3483@bogon.housecafe.de>
	<1262079255.2173.216.camel@pasglop>
	<20100106173745.57207520@hyperion.delvare>
	<alpine.DEB.2.01.1001061913310.3483@bogon.housecafe.de>
	<20100107171738.2c83b13e@hyperion.delvare>
	<20100129091857.3b7228db@hyperion.delvare>
	<1264800895.20211.120.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@ozlabs.org,
	Michael Hanselmann <linux-kernel@hansmi.ch>,
	LKML <linux-kernel@vger.kernel.org>, Stelian Pop <stelian@popies.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Jan 2010 08:34:55 +1100, Benjamin Herrenschmidt wrote:
> 
> > Ben, what about applying this patch of mine, as Christian reported it
> > fixed his oops?
> 
> Sure. I never quite know with i2c which ones you will apply directly and
> which ones you want to go through my tree :-)
> 
> Hopefully they should still be referened on patchwork, I'll dig there
> and pick them up.

Well, basically I pick patches that touch drivers/i2c/*, and I don't
pick patches that touch drivers/macintosh/*. When I can't build the
drivers, I don't really feel like pushing the patches myself.

-- 
Jean Delvare
