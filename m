Return-Path: <herbert@gondor.apana.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19FEF1A2C2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 16:16:41 +1000 (AEST)
Date: Wed, 9 Sep 2015 14:16:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, leosilva@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>, tim.gardner@canonical.com
Subject: Re: [PATCH] crypto: vmx - VMX crypto should depend on CONFIG_VSX
Message-ID: <20150909061632.GA17410@gondor.apana.org.au>
References: <1441779323-901-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441779323-901-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 09, 2015 at 04:15:23PM +1000, Michael Ellerman wrote:
> This code uses FP (floating point), Altivec and VSX. It can just depend on
> CONFIG_VSX though, because that already depends on FP and Altivec.
> 
> Otherwise we get lots of link errors such as:
> 
>   drivers/built-in.o: In function `.p8_aes_setkey':
>   aes.c:(.text+0x2d325c): undefined reference to `.enable_kernel_altivec'
>   aes.c:(.text+0x2d326c): undefined reference to `.enable_kernel_vsx'
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Could you please cc linux-crypto@vger.kernel.org?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
