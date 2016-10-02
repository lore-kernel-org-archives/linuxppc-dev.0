Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sn78363NCzDrSg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2016 01:38:11 +1100 (AEDT)
Date: Sun, 2 Oct 2016 22:37:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Marcelo Cerri <marcelo.cerri@canonical.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 George Wilson <gcwilson@us.ibm.com>,
 Claudio Carvalho <cclaudio@br.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@br.ibm.com>, joy.latten@canonical.com
Subject: Re: [PATCH] crypto: sha1-powerpc: little-endian support
Message-ID: <20161002143758.GC18268@gondor.apana.org.au>
References: <1474659116-4689-1-git-send-email-marcelo.cerri@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474659116-4689-1-git-send-email-marcelo.cerri@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 23, 2016 at 04:31:56PM -0300, Marcelo Cerri wrote:
> The driver does not handle endianness properly when loading the input
> data.
> 
> Signed-off-by: Marcelo Cerri <marcelo.cerri@canonical.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
