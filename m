Return-Path: <mel@skynet.ie>
Received: from calculon.skynet.ie (calculon.skynet.ie [193.1.99.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CAE8DDE16
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 20:58:39 +1000 (EST)
Date: Thu, 17 May 2007 11:40:08 +0100
To: Bob Picco <bob.picco@hp.com>
Subject: Re: PPC64 build breakage drivers/pci/hotplug/rpadlpar_sysfs.c
Message-ID: <20070517104008.GA667@skynet.ie>
References: <20070516133046.GB25792@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20070516133046.GB25792@localhost>
From: mel@skynet.ie (Mel Gorman)
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (16/05/07 09:30), Bob Picco didst pronounce:
> bob.picco@hp.com
> Bcc: 
> Subject: Re: 2.6.22-rc1-mm1 powerpc build breakage
> Reply-To: 
> In-Reply-To: <20070515201914.16944e04.akpm@linux-foundation.org>
> 
> /usr/src/linux-2.6.22-rc1-mm1/drivers/pci/hotplug/rpadlpar_sysfs.c:132: error: unknown field `subsys' specified in initializer
> /usr/src/linux-2.6.22-rc1-mm1/drivers/pci/hotplug/rpadlpar_sysfs.c:132: warning: initialization from incompatible pointer type
> make[4]: *** [drivers/pci/hotplug/rpadlpar_sysfs.o] Error 1
> make[3]: *** [drivers/pci/hotplug] Error 2
> make[2]: *** [drivers/pci] Error 2
> make[1]: *** [drivers] Error 2
> make: *** [_all] Error 2
> 

This is showing up on TKO as well and Andy Whitcroft has kicked it
around a bit as far as I know. He makes it build with this patch
http://test.kernel.org/abat/88951/build/patches/update-sysfs-kset-initialisation-in-PPC64-DLPAR-IO-driver

However, my understand is that the driver is broken even though it builds
but I don't recall why. I've added Andy to the CC

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
