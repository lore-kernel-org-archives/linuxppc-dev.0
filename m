Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C82EADDF0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 09:26:37 +1100 (EST)
Date: Fri, 22 Feb 2008 17:26:52 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: MODPOST section mismatches
In-Reply-To: <20080222145224.7349cf36@weaponx>
References: <20080221213313.97814DDF55@ozlabs.org>
	<20080222164210.48628DE0A9@ozlabs.org>
	<20080222145224.7349cf36@weaponx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080222222637.C82EADDF0F@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

FLAT_MEM is one of the configuration options:
       CONFIG_ARCH_FLATMEM_ENABLE=y

At 03:52 PM 2/22/2008, Josh Boyer wrote:
>On Fri, 22 Feb 2008 11:12:47 -0500
>Steve Heflin <sheflin@newagemicro.com> wrote:
>
> > To reproduce the problem and see the details on section mismatches:
> >
> >      make ARCH=powerpc sequoia_defconfig
> >
> >      make ARCH=powerpc CONFIG_DEBUG_SECTION_MISMATCH=y
>
>All of those warnings are in drivers or common code.  And yes, they
>should eventually all be fixed.
>
> > >After modifying the make launch to include the recommended option
> > >shown above, I see that the section mismatch warning is due to data
> > >structures containing the address of initialization modules which
> > >have the __init attribute. Since the memory model is FLAT, is 
> this a problem?
>
>What do you mean by "the memory model is FLAT"?
>
>josh
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
