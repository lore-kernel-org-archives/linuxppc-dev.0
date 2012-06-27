Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (sting.hengli.com.au [178.18.18.71])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A7C2C100D99
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 17:24:47 +1000 (EST)
Date: Wed, 27 Jun 2012 14:49:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] drivers: crypto: move nx build to driver/crypto
 Makefile
Message-ID: <20120627064859.GB22920@gondor.apana.org.au>
References: <1339611763-14603-1-git-send-email-sjenning@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339611763-14603-1-git-send-email-sjenning@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-crypto@vger.kernel.org, Kent Yoder <key@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2012 at 01:22:42PM -0500, Seth Jennings wrote:
> When the nx driver was pulled, the Makefile that actually
> builds it is arch/powerpc/Makefile. This is unnatural.
> 
> This patch moves the line that builds the nx driver from
> arch/powerpc/Makefile to drivers/crypto/Makefile where it
> belongs.
> 
> Cc: Kent Yoder <key@linux.vnet.ibm.com>
> Signed-off-by: Seth Jennings <sjenning@linux.vnet.ibm.com>

Both patches applied.

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
