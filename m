Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Fix bugs in fdt_get_path() 
In-reply-to: <20080829041913.GC30197@yookeroo.seuss> 
References: <20080829041913.GC30197@yookeroo.seuss>
Date: Thu, 25 Sep 2008 10:01:27 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KisLP-0007uK-Vf@jdl.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The current implementation of fdt_get_path() has a couple of bugs,
> fixed by this patch.
> 
> First, contrary to its documentation, on success it returns the length
> of the node's path, rather than 0.  The testcase is correspondingly
> wrong, and the patch fixes this as well.
> 
> Second, in some circumstances, it will return -FDT_ERR_BADOFFSET
> instead of -FDT_ERR_NOSPACE when given insufficient buffer space.
> Specifically this happens when there is insufficient space even to
> hold the path's second last component.  This behaviour is corrected,
> and the testcase updated to check it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
