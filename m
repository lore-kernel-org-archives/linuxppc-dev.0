Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E9D9367A3F
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 01:37:03 +1000 (EST)
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: ppc vs. powerpc status update, please 
In-Reply-To: Your message of "Sat, 01 Jul 2006 12:20:12 +0200."
	<Pine.LNX.4.60.0607011215260.7912@poirot.grange>
References: <Pine.LNX.4.60.0607011215260.7912@poirot.grange> 
Date: Sat, 01 Jul 2006 10:36:55 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FwhWh-00040w-BB@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Guennadi Liakhovetski mumbled:
> What's the _current_ trend with those 2 archs, specifically,respecting 
> embedded boards, the make ARCH=powerpc ***_defconfig for a board under ppc 
> "just should work" doesn't seem to hold and I didn't find any provisions 
> for that. (I read in an earlier post it "should"). Are ppc platforms still 
> supposed to migrate to under powerpc? I am not quite clear where to put 
> all board-specific stuff then, in that post it was told "you almost don't 
> need anything, just use device tree and a correct CPU support, and put 
> your specific _drivers_ somewhere". How is it in reality?

The trend is still happening.  Things should be migrated out
of arch/ppc and into arch/powerpc.  For example, I just 
introduced a new 86xx board port only under arch/powerpc.

Please feel free to help migrate support into arch/powerpc!

jdl
