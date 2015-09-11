Return-Path: <herbert@gondor.apana.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DA361A2AF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2015 10:50:38 +1000 (AEST)
Date: Fri, 11 Sep 2015 08:50:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, leosilva@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>, tim.gardner@canonical.com,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] crypto: vmx - VMX crypto should depend on CONFIG_VSX
Message-ID: <20150911005030.GB1690@gondor.apana.org.au>
References: <1441786955-6249-1-git-send-email-mpe@ellerman.id.au>
 <20150910092642.GA28753@gondor.apana.org.au>
 <1441932427.23806.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441932427.23806.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 11, 2015 at 10:47:07AM +1000, Michael Ellerman wrote:
>
> Is that targeted for 4.3 ?

Yes I'm only accepting 4.3 patches for the time being.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
