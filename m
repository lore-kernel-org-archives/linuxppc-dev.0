Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AB63DDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 09:40:07 +1100 (EST)
Date: Wed, 7 Nov 2007 01:40:10 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <7310408706.20071107014010@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] [PPC 4xx] L2-cache synchronization for ppc44x
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sr@denx.de, dzu@denx.de
Reply-To: Yuri Tikhonov <yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hello all,

 Here is a patch-set for support L2-cache synchronization routines for
the ppc44x processors family. I know that the "ppc" branch is for bug-fixing only, thus
the patch-set is just FYI [though enabled but non-coherent L2-cache may appear as a bug for
someone who uses one of the boards listed below :)].

[PATCH 1/2] [PPC 4xx] invalidate_l2cache_range() implementation for ppc44x;
[PATCH 2/2] [PPC 44x] enable L2-cache for the following ppc44x-based boards: ALPR,
Katmai, Ocotea, and Taishan.

 Regards, Yuri

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
