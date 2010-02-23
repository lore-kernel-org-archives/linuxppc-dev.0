Return-Path: <BATV+54e4ee8a974e2d9aaca0+2375+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D37DB7D22
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Feb 2010 23:51:03 +1100 (EST)
Subject: Re: [PATCH 4/4] Fix iMac iSight PCI bridge setup
From: David Woodhouse <dwmw2@infradead.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20100206010314.GP12001@hansolo.jdub.homelinux.org>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205135546.GJ12001@hansolo.jdub.homelinux.org>
	<1265403466.8287.218.camel@pasglop>
	<20100206010314.GP12001@hansolo.jdub.homelinux.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Feb 2010 12:50:57 +0000
Message-ID: <1266929457.30247.2587.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-05 at 20:03 -0500, Josh Boyer wrote:
> On Sat, Feb 06, 2010 at 07:57:46AM +1100, Benjamin Herrenschmidt wrote:
> >On Fri, 2010-02-05 at 08:55 -0500, Josh Boyer wrote:
> >> This works around the PCIe bridge setup on the iMac iSight boxen.
> >
> >Is this still needed ? I though I had fixed the root cause (incorrect
> >setup of the bridge) a while back...
> 
> I honestly have no clue, and I have no means of actually testing this.  I have
> an iMac running Fedora, but not the iSight version.  If you think it's fixed
> then I can just drop the patch from the Fedora kernel and we can wait for
> either silence or bug reports :)

I'll dig out the machine and test. Some time next month would be the
current estimate.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
