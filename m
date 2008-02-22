Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48628DE0A9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 03:42:00 +1100 (EST)
Date: Fri, 22 Feb 2008 11:12:47 -0500
To: linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: MODPOST section mismatches
In-Reply-To: <20080221213313.97814DDF55@ozlabs.org>
References: <20080221213313.97814DDF55@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080222164210.48628DE0A9@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

To reproduce the problem and see the details on section mismatches:

     make ARCH=powerpc sequoia_defconfig

     make ARCH=powerpc CONFIG_DEBUG_SECTION_MISMATCH=y

At 04:33 PM 2/21/2008, Steve Heflin wrote:
>while building vmlinux.o the MODPOST warns about 8 section mismatches.
>WARNING: modpost: Found 8 section mismatch(es).
>To see full details build your kernel with:
>'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>
>After modifying the make launch to include the recommended option
>shown above, I see that the section mismatch warning is due to data
>structures containing the address of initialization modules which
>have the __init attribute. Since the memory model is FLAT, is this a problem?
>
>thanks,
>Steve
>
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
