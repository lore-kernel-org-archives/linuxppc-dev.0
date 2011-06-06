Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 973E6B6FBB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jun 2011 02:25:04 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Date: Mon, 6 Jun 2011 18:24:53 +0200
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106061803.58531.arnd@arndb.de> <4DECFBC5.6070205@freescale.com>
In-Reply-To: <4DECFBC5.6070205@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106061824.53844.arnd@arndb.de>
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>, akpm@kernel.org,
	Deepak Saxena <dsaxena@linaro.org>,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 06 June 2011, Timur Tabi wrote:
> Arnd Bergmann wrote:
> > When we talked about the situation of drivers/misc and drivers/char at
> > one of the recent conferences, a broad consensus was that they are in
> > need of a maintainer, which I foolishly signed up for. Deepak wanted
> > to send an update to the MAINTAINERS file for this (I guess I can do
> > that too, since he must have forgotten about it), but the main idea is
> > that I'm there to say no to any driver that someone tries to add there,
> > unless there are really good reasons why it is actually a good place
> > to live for that driver.
> 
> Can you give me an example of a driver that does belong in drivers/misc?

Not really.

> Frankly, I just don't see what's wrong with a repository of various drivers that
> don't really belong anywhere else.

The main problem is that for the most part it's a pile of crap that
nobody wants to look at, so drivers getting added there see basically
no real review.

> And what about my concern that my driver will be the only one in drivers/virt?

I have no doubt that more of these will come. Chris Metcalf is currently
looking for a home for his tilera hypervisor drivers, and we have the
microsoft hyperv drivers in drivers/staging, so they will hopefully
move to a proper place later. We also have similar drivers in other
places, e.g. drivers/ps3/ps3-sys-manager.c, drivers/s390/char/vmcp.c
or parts of drivers/xen.

	Arnd
