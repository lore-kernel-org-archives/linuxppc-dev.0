Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCD35679E1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 09:36:05 +1000 (EST)
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20061019070318.GA24642@aepfle.de>
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>
	<4535C0F8.1070905@bplan-gmbh.de>
	<1161152109.7906.6.camel@localhost.localdomain>
	<20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 09:35:42 +1000
Message-Id: <1161300942.10524.64.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Thu, 2006-10-19 at 09:03 +0200, Olaf Hering wrote:
> On Thu, Oct 19, Benjamin Herrenschmidt wrote:
> 
> > On Wed, 2006-10-18 at 09:38 +0200, Olaf Hering wrote:
> > > On Wed, Oct 18, Michael Ellerman wrote:
> > > 
> > > > But it's called '/proc/ppc64' right now on lots of machines, so you
> > > > can't go changing it.
> > > 
> > > if test -d /proc/ppc64 .. is a quick way to check wether the system is
> > > 64bit or not. Similar to if test -d /proc/iSeries ..
> > 
> > That's really ugly ! You really do that ? Gack...
> 
> What way should I use?

uname ? /proc/cpuinfo ? Whatever but not that.

Ben.
