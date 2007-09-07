Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Assume properties preced subnodes in the flattened tree 
In-Reply-To: Your message of "Tue, 04 Sep 2007 10:43:03 +1000."
	<20070904004303.GC20549@localhost.localdomain>
References: <20070904004303.GC20549@localhost.localdomain> 
Date: Fri, 07 Sep 2007 08:41:09 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1ITe57-0008ED-J4@jdl.com>
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
> With kernel commit eff2ebd207af9f501af0ef667a7d14befcb36c1b, we
> clarified that in the flattened tree format, a particular nodes
> properties are required to precede its subdnodes.
> 
> At present however, both dtc and libfdt will process trees which don't
> meet this condition.  This patch simplifies the code for
> fdt_get_property() based on assuming that constraint.  dtc continues
> to be able to handle such an invalid tree - on the grounds that it's
> useful for dtc to be able to correct such a broken tree - but this
> patch adds a warning when this condition is not met while reading a
> flattened tree.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Applied.

Thanks,
jdl
