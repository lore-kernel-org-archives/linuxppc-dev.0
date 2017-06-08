Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjsMX6nrCzDqPG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 14:07:36 +1000 (AEST)
In-Reply-To: <20170505053458.csrwd2kjber44r4o@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: cxl: Unlock on error in probe
Message-Id: <3wjsMX598Gz9s9Y@ozlabs.org>
Date: Thu,  8 Jun 2017 14:07:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-05 at 05:34:58 UTC, Dan Carpenter wrote:
> We should unlock if get_cxl_adapter() fails.
> 
> Fixes: 594ff7d067ca ("cxl: Support to flash a new image on the adapter from a guest")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/58d876fa7181f2f393190c1d32c056

cheers
