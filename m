Return-Path: <satyam@infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 043AADDE38
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 23:35:11 +1000 (EST)
Date: Thu, 20 Sep 2007 19:07:52 +0530 (IST)
From: Satyam Sharma <satyam@infradead.org>
To: Mel Gorman <mel@skynet.ie>
Subject: 2.6.23-rc6-mm1: Build failures on ppc64_defconfig
In-Reply-To: <20070920132512.GF24105@skynet.ie>
Message-ID: <alpine.LFD.0.999.0709201903180.17093@enigma.security.iitk.ac.in>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070920132512.GF24105@skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Thu, 20 Sep 2007, Mel Gorman wrote:
> 
> allmodconfig on ppc64 fails to build with the following error

BTW ppc64_defconfig didn't quite like 2.6.23-rc6-mm1 either ...
IIRC I got build failures in:

drivers/ata/pata_scc.c
drivers/md/raid6int8.c
drivers/net/spider_net.c
drivers/net/pasemi_mac.c
drivers/pci/hotplug/rpadlpar_sysfs.c

I was in a hurry so didn't record the errors, just noted down the files
and disabled them from .config and continued building ... I'll get back
to fixing these up tonight (if you don't do that by then already).


Satyam
