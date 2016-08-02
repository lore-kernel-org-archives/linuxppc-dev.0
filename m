Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3lTP5PVtzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 04:43:37 +1000 (AEST)
Date: Tue, 2 Aug 2016 07:41:18 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org, antoine.blangy@c-s.fr
Subject: Re: [PATCH v2] powerpc/32: fix csum_partial_copy_generic()
Message-ID: <20160802124118.GA10155@gate.crashing.org>
References: <20160802080705.69A9F1A2394@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160802080705.69A9F1A2394@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2016 at 10:07:05AM +0200, Christophe Leroy wrote:
> commit 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
> based on copy_tofrom_user()") introduced a bug when destination
> address is odd and initial csum is not null
> 
> In that (rare) case the initial csum value has to be rotated one byte
> as well as the resulting value is
> 
> This patch also fixes related comments
> 
> Fixes: 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
> based on copy_tofrom_user()")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: updated comments as suggested by Segher

Thanks.  It looks good to me now.


Segher
