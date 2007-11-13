Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Add missing dependencies for tests 
In-Reply-To: Your message of "Tue, 13 Nov 2007 09:52:58 +1100."
	<20071112225258.GF1219@localhost.localdomain>
References: <20071112225258.GF1219@localhost.localdomain> 
Date: Tue, 13 Nov 2007 07:34:13 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Irvu9-0006QW-FN@jdl.com>
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
> At present, the Makefiles will not rebuild trees.o or the dtb files
> derived from it if testdata.h is updated.  This is incorrect, and is
> because of missing dependency information.
> 
> This patch fixes the problem by making sure that dependency
> information is generated from trees.S and dumptrees.c.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
