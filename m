Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BBBE1A2AF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2015 10:47:08 +1000 (AEST)
Message-ID: <1441932427.23806.2.camel@ellerman.id.au>
Subject: Re: [PATCH v2] crypto: vmx - VMX crypto should depend on CONFIG_VSX
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linuxppc-dev@ozlabs.org, leosilva@linux.vnet.ibm.com, Paul Mackerras
 <paulus@samba.org>, tim.gardner@canonical.com, linux-crypto@vger.kernel.org
Date: Fri, 11 Sep 2015 10:47:07 +1000
In-Reply-To: <20150910092642.GA28753@gondor.apana.org.au>
References: <1441786955-6249-1-git-send-email-mpe@ellerman.id.au>
 <20150910092642.GA28753@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-10 at 17:26 +0800, Herbert Xu wrote:
> On Wed, Sep 09, 2015 at 06:22:35PM +1000, Michael Ellerman wrote:
> > This code uses FP (floating point), Altivec and VSX (Vector-Scalar
> > Extension). It can just depend on CONFIG_VSX though, because that
> > already depends on FP and Altivec.
> > 
> > Otherwise we get lots of link errors such as:
> > 
> >   drivers/built-in.o: In function `.p8_aes_setkey':
> >   aes.c:(.text+0x2d325c): undefined reference to `.enable_kernel_altivec'
> >   aes.c:(.text+0x2d326c): undefined reference to `.enable_kernel_vsx'
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Applied.

Thanks.

Is that targeted for 4.3 ?

cheers
