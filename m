Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sn7CH0rRfzDrSg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2016 01:40:59 +1100 (AEDT)
Date: Sun, 2 Oct 2016 22:40:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Anton Blanchard <anton@samba.org>
Cc: Marcelo Cerri <marcelo.cerri@canonical.com>, linux-crypto@vger.kernel.org,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 George Wilson <gcwilson@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 0/3] Fix crypto/vmx/p8_ghash memory corruption
Message-ID: <20161002144047.GG18268@gondor.apana.org.au>
References: <1475080931-7926-1-git-send-email-marcelo.cerri@canonical.com>
 <20160929065908.653ec5c2@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160929065908.653ec5c2@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 29, 2016 at 06:59:08AM +1000, Anton Blanchard wrote:
> Hi Marcelo
> 
> > This series fixes the memory corruption found by Jan Stancek in
> > 4.8-rc7. The problem however also affects previous versions of the
> > driver.
> 
> If it affects previous versions, please add the lines in the sign off to
> get it into the stable kernels.

I have added them to patches 1 and 2.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
