Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 74F6E67B52
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 17:04:42 +1000 (EST)
Date: Thu, 19 Oct 2006 09:03:18 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061019070318.GA24642@aepfle.de>
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>
	<4535C0F8.1070905@bplan-gmbh.de>
	<1161152109.7906.6.camel@localhost.localdomain>
	<20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1161211083.10524.13.camel@localhost.localdomain>
Cc: akpm@osdl.org, tilmann@bitterberg.de, Sven Luther <sl@bplan-gmbh.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 19, Benjamin Herrenschmidt wrote:

> On Wed, 2006-10-18 at 09:38 +0200, Olaf Hering wrote:
> > On Wed, Oct 18, Michael Ellerman wrote:
> > 
> > > But it's called '/proc/ppc64' right now on lots of machines, so you
> > > can't go changing it.
> > 
> > if test -d /proc/ppc64 .. is a quick way to check wether the system is
> > 64bit or not. Similar to if test -d /proc/iSeries ..
> 
> That's really ugly ! You really do that ? Gack...

What way should I use?
