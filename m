Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Fix NOP handling bug in fdt_add_subnode_namelen() 
In-Reply-To: Your message of "Thu, 14 Feb 2008 16:50:34 +1100."
	<20080214055034.GA13137@localhost.localdomain>
References: <20080214055034.GA13137@localhost.localdomain> 
Date: Thu, 14 Feb 2008 08:05:07 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JPei3-0008KM-Pu@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> fdt_add_subnode_namelen() has a bug if asked to add a subnode to a
> node which has NOP tags interspersed with its properties.  In this
> case fdt_add_subnode_namelen() will put the new subnode before the
> first NOP tag, even if there are properties after it, which will
> result in an invalid blob.
> 
> This patch fixes the bug, and adds a testcase for it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
