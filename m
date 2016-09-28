Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skMXD3s6jzDrYr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 12:46:04 +1000 (AEST)
Date: Wed, 28 Sep 2016 10:45:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Marcelo Cerri <marcelo.cerri@canonical.com>
Cc: Jan Stancek <jstancek@redhat.com>, rui y wang <rui.y.wang@intel.com>,
 mhcerri@linux.vnet.ibm.com, leosilva@linux.vnet.ibm.com,
 pfsmorigo@linux.vnet.ibm.com, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [bug] crypto/vmx/p8_ghash memory corruption in 4.8-rc7
Message-ID: <20160928024549.GB14034@gondor.apana.org.au>
References: <450861381.1559123.1474673197124.JavaMail.zimbra@redhat.com>
 <1655600242.1561022.1474676547316.JavaMail.zimbra@redhat.com>
 <20160926145934.GA5520@gondor.apana.org.au>
 <20160926174317.GA21317@gallifrey>
 <20160927030826.GB8579@gondor.apana.org.au>
 <346154437.225735.1474966863173.JavaMail.zimbra@redhat.com>
 <20160927120414.GC21317@gallifrey>
 <20160927194644.GB15729@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160927194644.GB15729@gallifrey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 27, 2016 at 04:46:44PM -0300, Marcelo Cerri wrote:
> 
> Can you check if the problem occurs with this patch?

In light of the fact that padlock-sha is the correct example
to follow, you only need to add one line to the init_tfm fucntion
to update the descsize based on that of the fallback.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
