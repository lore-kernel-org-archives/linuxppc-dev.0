Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 67B86DDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 12:18:50 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 9/9] powerpc/cell: Add DMA_ATTR_STRONG_ORDERING dma
	attribute and use in IOMMU code
References: <20080715195139.316677337@arndb.de>
	<20080715195740.098068951@arndb.de> <ada3amaevj5.fsf@cisco.com>
	<200807152327.06946.arnd@arndb.de>
Date: Tue, 15 Jul 2008 19:18:46 -0700
In-Reply-To: <200807152327.06946.arnd@arndb.de> (Arnd Bergmann's message of
	"Tue, 15 Jul 2008 23:27:06 +0200")
Message-ID: <ada7ibmd115.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > This is all about inbound transfers, i.e. DMAs coming from the I/O bridge
 > into the CPU, both DMA read and DMA write.

OK -- at a minimum I think the documentation should make that clear.  As
it stands the description of what this does is pretty much impossible to
parse and understand.

 > Strong ordering is only active when both the bridge and the IOMMU enable
 > it, but for correctly written drivers, this only results in a slowdown.

So when would someone use this dma attribute?  As a hack to fix drivers
where the real fix is too complicated?

 - R.
