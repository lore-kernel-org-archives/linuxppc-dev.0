Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4D41DDEE3
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 11:49:24 +1000 (EST)
Subject: Re: [PATCH 08/10] cell: add support for proper device-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200704240116.58364.arnd@arndb.de>
References: <20070423193538.576702568@arndb.de>
	<20070423193913.253050755@arndb.de> <200704240116.58364.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 11:48:25 +1000
Message-Id: <1177379305.14873.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Woodhouse <dwmw2@infradead.org>, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-24 at 01:16 +0200, Arnd Bergmann wrote:
> On Monday 23 April 2007, Arnd Bergmann wrote:
> > From: Christian Krafft <krafft@de.ibm.com>
> > 
> > This patch adds support for a proper device-tree.
> > A porper device-tree on cell contains be nodes
> > for each CBE containg nodes for SPEs and all the
> > other special devices on it.
> > Ofcourse oldschool devicetree is still supported.
> > 
> > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> > Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> 
> Christian, I only now saw that there is this rather important
> patch left, it never stood out as something for 2.6.21 and now
> it's too late for that.
> This might explain why people could not boot some hardware
> with Fedora 7.
> 
> Should we try to get this in as a hotfix?

Please do.

Ben.
