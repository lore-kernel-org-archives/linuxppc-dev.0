Return-Path: <jdl@jdl.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: libfdt: Add fdt_set_name() function 
In-Reply-To: Your message of "Fri, 11 Jan 2008 08:30:03 CST."
	<20080111083003.38b556d6@zod.rchland.ibm.com>
References: <20080111035505.GB25055@localhost.localdomain>
	<E1JDKBV-0007Hq-Dm@jdl.com>
	<20080111083003.38b556d6@zod.rchland.ibm.com>
Date: Fri, 11 Jan 2008 08:38:15 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JDL1T-0007bi-Mm@jdl.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Josh Boyer mumbled:
> On Fri, 11 Jan 2008 07:44:33 -0600
> Jon Loeliger <jdl@jdl.com> wrote:
> 
> > So, like, the other day David Gibson mumbled:
> > > This patch adds an fdt_set_name() function to libfdt, mirroring
> > > fdt_get_name().  This is a r/w function which alters the name of a
> > > given device tree node.
> > > 
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > 
> > Applied.
> 
> Awesome.  Now if we could just get that into the kernel and usable in
> the wrappers... :)

I've pushed it out now.

I guess we'll try to get the real v1.1.0 into the kernel then?
Maybe at 2.6.25?

jdl
