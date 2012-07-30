Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (sting.hengli.com.au [178.18.18.71])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 381BE2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 17:56:52 +1000 (EST)
Date: Mon, 30 Jul 2012 15:56:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] powerpc/crypto: IBM Power7+ in-Nest compression
 support
Message-ID: <20120730075628.GE5515@gondor.apana.org.au>
References: <1342708961-28587-1-git-send-email-sjenning@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342708961-28587-1-git-send-email-sjenning@linux.vnet.ibm.com>
Cc: Kent Yoder <key@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 19, 2012 at 09:42:37AM -0500, Seth Jennings wrote:
> This is a continuation of support for the Power7+ in-Nest
> hardware accelerator.
> 
> https://lkml.org/lkml/2012/4/12/223
> 
> This patchset adds the hardware driver and the cryptographic
> driver for hardware accelerated compression, which uses a
> hardware-optimized algorithm named 842.
> 
> The hardware driver has limits on generic compression and is
> geared toward compressing units that are of PAGE_SIZE for
> in-kernel memory compression.
> 
> Based on linux-next (20120717)
> 
> Seth Jennings (4):

All applied.  Thanks Seth.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
