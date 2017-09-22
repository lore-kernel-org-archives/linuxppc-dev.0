Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz8Sk5Gm0zDsM4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 20:13:26 +1000 (AEST)
Date: Fri, 22 Sep 2017 18:13:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: mpm@selenic.com, mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] hwrng: pseries: constify vio_device_id
Message-ID: <20170922101302.GD16270@gondor.apana.org.au>
References: <ba527ef090617a90e6909bab75b09e1c1ac8be68.1502990171.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ba527ef090617a90e6909bab75b09e1c1ac8be68.1502990171.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 17, 2017 at 11:06:23PM +0530, Arvind Yadav wrote:
> vio_device_id are not supposed to change at runtime. All functions
> working with vio_device_id provided by <asm/vio.h> work with
> const vio_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
