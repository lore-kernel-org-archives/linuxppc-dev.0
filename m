Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A23D867B6F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 07:19:52 +1000 (EST)
Subject: Re: pci error recovery procedure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20060905185020.GD7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	<20060831175001.GE8704@austin.ibm.com>
	<1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	<20060901212548.GS8704@austin.ibm.com>
	<1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	<1157360592.22705.46.camel@localhost.localdomain>
	<20060905185020.GD7139@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 07:19:11 +1000
Message-Id: <1157491152.22705.133.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
	Yanmin Zhang <yanmin.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linuxppc-dev@ozlabs.org,
	linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-05 at 13:50 -0500, Linas Vepstas wrote:
> On Mon, Sep 04, 2006 at 07:03:12PM +1000, Benjamin Herrenschmidt wrote:
> > 
> > > As you know, all functions of a device share the same bus number and 5 bit dev number.
> > > They just have different 3 bit function number. We could deduce if functions are in the same
> > > device (slot).
> > 
> > Until you have a P2P bridge ...
> 
> And this is not theoretical: for example, the matrox graphics cards:
> 
> 0000:c8:01.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 13)
> 0000:c9:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85)

It's also very common with multiple ports network cards

Ben.
