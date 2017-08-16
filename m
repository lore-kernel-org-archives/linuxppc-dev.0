Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTFH2FXZzDrK9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:29:55 +1000 (AEST)
In-Reply-To: <20170811200541.qlxcpp3og33sdki3@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: Re: powerpc/perf: double unlock bug in imc_common_cpuhp_mem_free()
Message-Id: <3xXTFG6ryjz9t42@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-11 at 20:05:41 UTC, Dan Carpenter wrote:
> There is a typo so we call unlock instead of lock.
> 
> Fixes: 885dcd709ba9 ("powerpc/perf: Add nest IMC PMU support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b3376dcc6c62452fe24e76d8fc35bb

cheers
