Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4grB1hrlzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 17:03:05 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jeremy Kerr <jk@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] ppc/cell: missing error code in spufs_mkgang()
Date: Thu, 04 Aug 2016 09:02:35 +0200
Message-ID: <2833167.fj71jLNsZj@wuerfel>
In-Reply-To: <20160804053703.GN775@mwanda>
References: <20160804053703.GN775@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, August 4, 2016 8:37:03 AM CEST Dan Carpenter wrote:
> We should return -ENOMEM if alloc_spu_gang() fails.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
