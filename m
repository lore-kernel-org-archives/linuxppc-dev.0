Return-Path: <jdl@jdl.com>
To: Kumar Gala <galak@kernel.crashing.org>, jwboyer@linux.vnet.ibm.com,
	ppc-dev list <linuxppc-dev@ozlabs.org>, monstr@seznam.cz,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Increase namespace-pollution paranoia 
Date: Mon, 14 Jul 2008 14:08:16 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KITPE-0006uu-P7@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> My (DTC) plan is to apply the single patch with some
> include file fixes, and release that.
> 
> I'll line the slew of patches up for the following release.
> 
> jdl

And that's not at all what happened.

One of David's patches (BSD portability) was a superset of the
include-file fixes supplied as a point-solution in a different
patch.  So I applied David's more-general patch.

In fact, I applied all of David's outstanding patches and
have tagged it v1.2.0-rc2 and pushed it out now.

Please let me know if you have other fixes before I make
and release a non -rc version.

Thanks,
jdl
