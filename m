Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5FDD4DE5FF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 07:52:29 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1MKqQ1N001603
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Feb 2008 15:52:26 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1MKqQ6I310106
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Feb 2008 15:52:26 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1MKqQAG013072
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Feb 2008 15:52:26 -0500
Date: Fri, 22 Feb 2008 14:52:24 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: MODPOST section mismatches
Message-ID: <20080222145224.7349cf36@weaponx>
In-Reply-To: <20080222164210.48628DE0A9@ozlabs.org>
References: <20080221213313.97814DDF55@ozlabs.org>
	<20080222164210.48628DE0A9@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 22 Feb 2008 11:12:47 -0500
Steve Heflin <sheflin@newagemicro.com> wrote:

> To reproduce the problem and see the details on section mismatches:
> 
>      make ARCH=powerpc sequoia_defconfig
> 
>      make ARCH=powerpc CONFIG_DEBUG_SECTION_MISMATCH=y

All of those warnings are in drivers or common code.  And yes, they
should eventually all be fixed.

> >After modifying the make launch to include the recommended option
> >shown above, I see that the section mismatch warning is due to data
> >structures containing the address of initialization modules which
> >have the __init attribute. Since the memory model is FLAT, is this a problem?

What do you mean by "the memory model is FLAT"?

josh
