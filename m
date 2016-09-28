Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skdcY25TgzDrR4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 23:20:45 +1000 (AEST)
Date: Wed, 28 Sep 2016 21:20:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Marcelo Cerri <marcelo.cerri@canonical.com>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 George Wilson <gcwilson@us.ibm.com>,
 Claudio Carvalho <cclaudio@br.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@br.ibm.com>,
 joy.latten@canonical.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: sha1-powerpc: little-endian support
Message-ID: <20160928132015.GA21312@gondor.apana.org.au>
References: <1474659116-4689-1-git-send-email-marcelo.cerri@canonical.com>
 <20160928131551.GA31082@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160928131551.GA31082@gallifrey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2016 at 10:15:51AM -0300, Marcelo Cerri wrote:
> Hi Herbert,
> 
> Any thoughts on this one?

Can this patch wait until the next merge window? On the broken
platforms it should just fail the self-test, right?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
