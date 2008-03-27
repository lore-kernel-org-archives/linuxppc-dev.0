Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F564DE0B8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 12:11:43 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2R1A5TD003559
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Mar 2008 21:10:05 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2R1BaQF127794
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Mar 2008 19:11:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2R1BZkt023221
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Mar 2008 19:11:36 -0600
Date: Wed, 26 Mar 2008 20:08:57 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: ppc platform for AMCC-440EPx - ELDK to the rescue
Message-ID: <20080326200857.054078f5@zod.rchland.ibm.com>
In-Reply-To: <20080326130837.762DBDE2FB@ozlabs.org>
References: <20080326130837.762DBDE2FB@ozlabs.org>
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

On Wed, 26 Mar 2008 09:08:03 -0400
Steve Heflin <sheflin@newagemicro.com> wrote:

>  FINALLY the 
> early debugging console output worked, which doesn't work at all 
> using the powerpc platform (and yes, I had the correct port address 
> configured). 

It should work.  It did when the board support was first brought in to
arch/powerpc. If it doesn't now, I consider that a regression that needs
fixing, at least for Sequoia itself.
 
> Looking back at the powerpc platform, I don't see how to disable the 
> Host Bridge initialization without disabling the entire PCI 
> bus.  This board does have 2 devices hooked on the PCI bus, just no 
> need for a Host Bridge.

As Scott said, how would you talk to any PCI device without the host
bridge being configured and enabled?

> Also, I fail to see what the DTS virtualization layer of the hardware 
> buys us. When debugging, it's so much harder to use than the ppc 
> platform's straight forward and standard methodologies.  I can't 

There are tradeoffs, yes.

> understand to goal to eliminate the ppc platform, especially given 
> the fact that DENX's ELDK is still using it with Linux 2.6.24.2 !!

The ELDK uses both arch/ppc and arch/powerpc.  I consider them quite
reasonable people, and foresee them eventually switching to
arch/powerpc over time.  In fact, their efforts are a large part of the
continued progress of 4xx on arch/powerpc.

josh
