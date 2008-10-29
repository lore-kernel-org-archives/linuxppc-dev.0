Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18714DDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 07:57:38 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9TKuxO7005098
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 16:57:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9TKuxkK136986
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 16:56:59 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9TKuxLU012615
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 16:56:59 -0400
Message-ID: <4908CE18.3030205@linux.vnet.ibm.com>
Date: Wed, 29 Oct 2008 15:56:56 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: stable@kernel.org
Subject: 16G related patches for stable kernel 2.6.27
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please consider the following patches for the 2.6.27 stable tree.

The first two allow a powerpc machine with more then 2 numa nodes
to boot when 16G pages are enabled.  The third one allows a powerpc
machine to boot if using 16G pages and the mem= boot param.

thanks,
Jon


powerpc: Reserve in bootmem lmb reserved regions that cross NUMA nodes
    commit 8f64e1f2d1e09267ac926e15090fd505c1c0cbcb
powerpc/numa: Make memory reserve code more robust
    commit e81703724a966120ace6504c993bda9e084cbf3e
powerpc: Don't use a 16G page if beyond mem= limits
    commit 4792adbac9eb41cea77a45ab76258ea10d411173
