Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A311BDE066
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 01:30:49 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0BEUkQk022654
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 09:30:46 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0BEUjp4087556
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 07:30:45 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0BEUjdP032429
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 07:30:45 -0700
Date: Fri, 11 Jan 2008 08:30:03 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: libfdt: Add fdt_set_name() function
Message-ID: <20080111083003.38b556d6@zod.rchland.ibm.com>
In-Reply-To: <E1JDKBV-0007Hq-Dm@jdl.com>
References: <20080111035505.GB25055@localhost.localdomain>
	<E1JDKBV-0007Hq-Dm@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 11 Jan 2008 07:44:33 -0600
Jon Loeliger <jdl@jdl.com> wrote:

> So, like, the other day David Gibson mumbled:
> > This patch adds an fdt_set_name() function to libfdt, mirroring
> > fdt_get_name().  This is a r/w function which alters the name of a
> > given device tree node.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Applied.

Awesome.  Now if we could just get that into the kernel and usable in
the wrappers... :)

josh
