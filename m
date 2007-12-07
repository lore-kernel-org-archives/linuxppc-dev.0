Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 91870DDDF0
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 09:01:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
Date: Fri, 7 Dec 2007 23:01:38 +0100
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
In-Reply-To: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712072301.38723.arnd@arndb.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 07 December 2007, Balbir Singh wrote:
> Here's a dumb simple implementation of fake NUMA nodes for PowerPC. Fake
> NUMA nodes can be specified using the following command line option
> 
> numa=fake=<node range>
> 
> node range is of the format <range1>,<range2>,...<rangeN>

Excellent idea! I'd love to have this in RHEL5u1, because that would make
that distro boot on certain machines that have more memory than is supported
without an iommu driver. The problem we have is that when you simply
say mem=1G but all of the first gigabyte is on the first node, you end
up with a memoryless node, which is not supported.

Unfortunately, it comes too late for me now, as all new distros already boot
on Cell machines that need an IOMMU.

	Arnd <><
