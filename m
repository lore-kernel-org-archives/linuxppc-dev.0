Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6058DDEF6
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 12:18:40 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2M1IbEA025924
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 21:18:37 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2M1IaeX156638
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 19:18:36 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2M1Ia5t009228
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 19:18:36 -0600
Date: Fri, 21 Mar 2008 20:17:04 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: dcr stuff.
Message-ID: <20080321201704.032999c3@zod.rchland.ibm.com>
In-Reply-To: <20080321190524.4F3491CE0087@mail160-dub.bigfish.com>
References: <20080321190524.4F3491CE0087@mail160-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Mar 2008 12:05:40 -0700
"Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com> wrote:

> 
> Is anybody working on the dcr infrastructure?
> 
> In particular, there seems to be inconsistency between what the kernel
> does and what ePAPR thinks it should.  The code in the kernel selects
> mmio or native access based on a Kconfig parameter and uses some device
> tree parameters to correctly configure the mmio access, whereas ePAPR
> doesn't seem to document all the device tree attributes (in particular,
> dcr-mmio-stride and dcr-mmio-range) and provides a dynamic binding for
> dcr-access-method...

Code can be fixed if needs be.  Keep in mind that ePAPR isn't publicly
available yet.

> Is there a plan here?  (In particular, in FPGA designs, its possible to
> have crazy things like multiple independent dcr busses, some using
> native access, some using mmio.  Or even if there is one bus, many of
> the existing non-linux drivers we have assume native or mmio access.
> I'd like to clean this up, obviously.. :)

Clean it up how?  I'd hate to add bloat to boards with native DCR
access just because a few require oddities.

If it ain't broke, don't fix it.

josh
