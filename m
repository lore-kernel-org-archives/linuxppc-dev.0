Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (sting.hengli.com.au [178.18.18.71])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A2573B6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2012 13:58:33 +1000 (EST)
Date: Thu, 17 May 2012 13:22:36 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the crypto tree with the powerpc tree
Message-ID: <20120517032236.GA11236@gondor.apana.org.au>
References: <20120517132116.8a5378bce254fc39d20cb08a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120517132116.8a5378bce254fc39d20cb08a@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 Andreas Westin <andreas.westin@stericsson.com>,
 Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 17, 2012 at 01:21:16PM +1000, Stephen Rothwell wrote:
> Hi Herbert,
> 
> Today's linux-next merge of the crypto tree got a conflict in
> drivers/crypto/Kconfig between commit aef7b31c8833 ("powerpc/crypto:
> Build files for the nx device driver") from the powerpc tree and commit
> 2789c08fffea ("crypto: ux500 - Add driver for CRYP hardware") from the
> crypto tree.
> 
> Just context changes.  I fixed it up (see below) and can carry the fix as
> necessary.

Looks fine.  Thanks Stephen!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
