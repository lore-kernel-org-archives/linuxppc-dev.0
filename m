Return-Path: <haveblue@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54262DDE08
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 04:38:56 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1EHeYPB006358
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 12:40:34 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1EHcclk2121872
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 12:38:38 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1EHcb4U014167
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 10:38:38 -0700
Subject: Re: [PATCH] drivers/base: export gpl (un)register_memory_notifier
From: Dave Hansen <haveblue@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <1203010575.12312.6.camel@dyn9047017100.beaverton.ibm.com>
References: <200802111724.12416.ossthema@de.ibm.com>
	<1202748429.8276.21.camel@nimitz.home.sr71.net>
	<200802131617.58646.ossthema@de.ibm.com>
	<OF64B9886B.CE795DED-ONC12573EF.002FFA8B-C12573EF.00301683@de.ibm.com>
	<1203009163.19205.42.camel@nimitz.home.sr71.net>
	<1203010575.12312.6.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 14 Feb 2008 09:38:45 -0800
Message-Id: <1203010725.19205.44.camel@nimitz.home.sr71.net>
Mime-Version: 1.0
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>, ossthema@linux.vnet.ibm.com,
	Jan-Bernd Themann <THEMANN@de.ibm.com>, Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	apw <apw@uk.ibm.com>, linuxppc-dev@ozlabs.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, tklein@linux.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-02-14 at 09:36 -0800, Badari Pulavarty wrote:
> 
> I am not sure what you are trying to do with walk_memory_resource().
> The
> behavior is different on ppc64. Hotplug memory usage assumes that all
> the memory resources (all system memory, not just IOMEM) are
> represented
> in /proc/iomem. Its the case with i386 and ia64. But on ppc64 is
> contains ONLY iomem related. Paulus didn't want to export all the
> system
> memory into /proc/iomem on ppc64. So I had to workaround by providing
> arch-specific walk_memory_resource() function for ppc64.

OK, let's use that one.

-- Dave
