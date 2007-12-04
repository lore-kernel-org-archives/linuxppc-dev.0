Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94709DDE17
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 23:20:51 +1100 (EST)
Date: Tue, 4 Dec 2007 13:20:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUG] 2.6.24-rc3-git2 softlockup detected
Message-ID: <20071204122005.GA27286@elte.hu>
References: <474D0AAC.5010005@linux.vnet.ibm.com>
	<20071127225328.9e3f3827.akpm@linux-foundation.org>
	<474D15FF.5080508@linux.vnet.ibm.com>
	<20071127232552.ad16e95c.akpm@linux-foundation.org>
	<474E5CAC.9000108@linux.vnet.ibm.com>
	<20071129003533.54b4b20e.akpm@linux-foundation.org>
	<20071130063929.GD2754@fattire.cabal.ca>
	<20071129230047.1b482562.akpm@linux-foundation.org>
	<20071129230204.8698f47e.akpm@linux-foundation.org>
	<474FBB86.5000004@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <474FBB86.5000004@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-scsi@vger.kernel.org,
	Matthew Wilcox <willy@debian.org>, LKML <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> > So 2.6.24-rc3 was OK and 2.6.24-rc3-git2 is not?
> 
> Yes, the 2.6.24-rc3 was Ok and this is seen from 2.6.24-rc3-git2/3/4.

just to make sure: this is a real lockup and failed bootup (or device 
init), not just a message, right?

	Ingo
