Return-Path: <brking@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C73B6DDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 23:37:56 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l4HDY5Yo023635
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 09:34:05 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4HDbhEC254028
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 07:37:43 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4HDbh0N002437
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 07:37:43 -0600
Message-ID: <464C5AA5.3090002@linux.vnet.ibm.com>
Date: Thu, 17 May 2007 08:37:41 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Mel Gorman <mel@skynet.ie>
Subject: Re: PPC64 build breakage drivers/pci/hotplug/rpadlpar_sysfs.c
References: <20070516133046.GB25792@localhost> <20070517104008.GA667@skynet.ie>
In-Reply-To: <20070517104008.GA667@skynet.ie>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Bob Picco <bob.picco@hp.com>
Reply-To: brking@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mel Gorman wrote:
> On (16/05/07 09:30), Bob Picco didst pronounce:
>> bob.picco@hp.com
>> /usr/src/linux-2.6.22-rc1-mm1/drivers/pci/hotplug/rpadlpar_sysfs.c:132: error: unknown field `subsys' specified in initializer
>> /usr/src/linux-2.6.22-rc1-mm1/drivers/pci/hotplug/rpadlpar_sysfs.c:132: warning: initialization from incompatible pointer type
>> make[4]: *** [drivers/pci/hotplug/rpadlpar_sysfs.o] Error 1
>> make[3]: *** [drivers/pci/hotplug] Error 2
>> make[2]: *** [drivers/pci] Error 2
>> make[1]: *** [drivers] Error 2
>> make: *** [_all] Error 2
>>
> 
> This is showing up on TKO as well and Andy Whitcroft has kicked it
> around a bit as far as I know. He makes it build with this patch
> http://test.kernel.org/abat/88951/build/patches/update-sysfs-kset-initialisation-in-PPC64-DLPAR-IO-driver
> 
> However, my understand is that the driver is broken even though it builds
> but I don't recall why. I've added Andy to the CC

Al Viro posted a patch yesterday that fixes this:

http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036222.html

It's in mainline now.

-Brian
